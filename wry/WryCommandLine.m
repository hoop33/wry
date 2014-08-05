//
//  WryCommandLine.m
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "WryCommandLine.h"
#import "WryCommand.h"
#import "WrySetting.h"
#import "WryUtils.h"
#import "VersionSetting.h"
#import "WryErrorCodes.h"
#import "CountSetting.h"
#import "FormatSetting.h"
#import "RepeatSetting.h"

#define kMaxCount 200

@implementation WryCommandLine

- (id)init {
  self = [super init];
  if (self != nil) {
    _overrides = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (BOOL)parseString:(NSString *)commandLine error:(NSError **)error {
  NSArray *parameters = nil;
  if (commandLine.length > 0) {
    NSMutableArray *params = [NSMutableArray array];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\w\\-@]+|\".*\""
                                                                           options:0
                                                                             error:error];
    if (regex != nil) {
      [regex enumerateMatchesInString:commandLine
                              options:0
                                range:NSMakeRange(0, commandLine.length)
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             [params addObject:[[commandLine substringWithRange:result.range]
                               stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
                           }];
    }
    parameters = [params copy];
  }
  return [self parseParameters:parameters error:error];
}

- (BOOL)parseParameters:(NSArray *)parameters error:(NSError **)error {
  NSString *errorMessage = nil;
  NSMutableArray *params = [NSMutableArray array];
  for (NSUInteger i = 0, n = parameters.count; i < n; i++) {
    NSString *param = parameters[i];
    if ([param hasPrefix:@"-"]) {
      id <WrySetting> setting = [self settingForFlag:[param stringByReplacingOccurrencesOfString:@"-" withString:@""]];
      if (setting == nil) {
        errorMessage = [NSString stringWithFormat:@"Unknown flag: %@", param];
        break;
      } else {
        NSUInteger num = [setting numberOfParameters];
        i += num;
        if (i >= n) {
          errorMessage = [NSString stringWithFormat:@"Missing parameter for %@", param];
          break;
        } else {
          [self setOverrideValue:parameters[i] forSetting:setting];
        }
      }
    } else if (self.commandName == nil) {
      self.commandName = param;
    } else {
      [params addObject:param];
    }
  }
  if (errorMessage != nil) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:[WryApplication application].errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    }
    return NO;
  } else {
    self.params = [NSArray arrayWithArray:params];
    if (self.commandName == nil) {
      self.commandName = [(NSNumber *) self.overrides[[WryUtils nameForSettingForClass:[VersionSetting class]]] boolValue] ?
        @"version" : @"help";
    }
  }
  return YES;
}

- (int)run {
  int returnCode = WrySuccessCode;

  WryApplication *application = [WryApplication application];
  if (abs((int) [self integerValue:[WryUtils nameForSettingForClass:[CountSetting class]]]) > kMaxCount) {
    [application println:[NSString stringWithFormat:@"count must be between -%d and %d", kMaxCount, kMaxCount]];
    returnCode = WryErrorCodeBadInput;
  } else {
    NSString *formatterName = [self stringValue:[WryUtils nameForSettingForClass:[FormatSetting class]]];
    id <WryFormatter> formatter = [WryUtils formatterForName:formatterName];
    if (formatter == nil) {
      [application println:[NSString stringWithFormat:@"%@: '%@' is not a %@ format. See '%@ help'.", application.appName,
                                                      formatterName, application.appName, application.appName]];
      returnCode = WryErrorCodeBadInput;
    } else {
      id <WryCommand> wryCommand = [WryUtils commandForName:self.commandName];
      if (wryCommand == nil) {
        [application println:[NSString stringWithFormat:@"%@: '%@' is not a %@ command. See '%@ help'.", application.appName,
                                                        self.commandName, application.appName, application.appName]];
        returnCode = WryErrorCodeBadInput;
      } else {
        NSError *error;
        // Delete any runtime data we've stored on previous runs
        if (![WryUtils deleteRuntimeInfo:&error]) {
          returnCode = [self processError:error];
        } else {
          // Figure out how many seconds to sleep, if appropriate
          NSDictionary *options = [application.settings mergeWithOptions:self.overrides];
          NSInteger seconds = [options[[WryUtils nameForSettingForClass:[RepeatSetting class]]] integerValue];
          do {
            // Run the command
            if ([wryCommand run:self.params
                      formatter:formatter
                        options:options
                          error:&error]) {
              // Sleep <repeat> seconds
              if (seconds > 0) {
                [NSThread sleepForTimeInterval:seconds];
              }
            } else {
              [self processError:error];
            }
          } while (seconds > 0);
        }
      }
    }
  }
  return returnCode;
}

- (int)processError:(NSError *)error {
  if (error != NULL) {
    [[WryApplication application] println:error.localizedDescription];
    return (int) error.code;
  } else {
    return WryErrorCodeUnknown;
  }
}

- (void)setOverrideValue:(NSString *)value forSetting:(id <WrySetting>)setting {
  NSObject *object = nil;
  switch ([setting type]) {
    case WrySettingUnknownType:
      break;
    case WrySettingBooleanType:
      object = @YES;
      break;
    case WrySettingIntegerType:
      object = [NSNumber numberWithInteger:[value integerValue]];
      break;
    case WrySettingStringType:
      object = value;
      break;
  }
  if (object != nil) {
    [self.overrides setObject:object forKey:[WryUtils nameForSetting:setting]];
  }
}


- (NSString *)stringValue:(NSString *)key {
  return [[self.overrides allKeys] containsObject:key] ? (NSString *) self.overrides[key] :
    [[WryApplication application].settings stringValue:key];
}

- (NSInteger)integerValue:(NSString *)key {
  return [[self.overrides allKeys] containsObject:key] ? [(NSNumber *) self.overrides[key] integerValue] :
    [[WryApplication application].settings integerValue:key];
}

- (id <WrySetting>)settingForFlag:(NSString *)flag {
  id <WrySetting> setting = nil;
  switch (flag.length) {
    case 0:
      break;
    case 1:
      setting = [WryUtils settingForShortFlag:flag];
      break;
    default:
      setting = [WryUtils settingForName:flag];
      break;
  }
  return setting;
}

@end
