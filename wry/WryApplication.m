//
//  WryApplication.m
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "WryCommand.h"
#import "WryErrorCodes.h"
#import "SSKeychain.h"
#import "WryUtils.h"
#import "AnnotationsSetting.h"
#import "CountSetting.h"
#import "FormatSetting.h"
#import "QuietSetting.h"
#import "UserSetting.h"
#import "VersionSetting.h"

#define kMaxCount 200
#define kInputBufferSize 512

@implementation WryApplication

+ (WryApplication *)application {
  static WryApplication *application;

  @synchronized (self) {
    if (!application) application = [[WryApplication alloc] init];
    return application;
  }
}

+ (int)maximumPostLength {
  return 256;
}

- (id)init {
  self = [super init];
  if (self != nil) {
    _interactiveIn = isatty(fileno(stdin)) != 0;
    _interactiveOut = isatty(fileno(stdout)) != 0;
    self.settings = [[WrySettings alloc] init];
  }
  return self;
}

- (BOOL)parseCommandLine:(NSArray *)commandLineParameters {
  NSString *errorMessage = nil;
  NSMutableArray *params = [NSMutableArray array];
  for (NSUInteger i = 0, n = commandLineParameters.count; i < n; i++) {
    NSString *param = commandLineParameters[i];
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
          [self.settings setTransientValue:commandLineParameters[i] forSetting:setting];
        }
      }
    } else if (self.commandName == nil) {
      self.commandName = param;
    } else {
      [params addObject:param];
    }
  }
  if (errorMessage != nil) {
    [self println:errorMessage];
    return NO;
  } else {
    self.params = [NSArray arrayWithArray:params];
    if (self.commandName == nil) {
      self.commandName = [self.settings boolValue:[WryUtils nameForSettingForClass:[VersionSetting class]]] ?
        @"version" : @"help";
    }
  }
  return YES;
}

- (int)run {
  int returnCode = WrySuccessCode;
  if (abs((int) [self.settings integerValue:[WryUtils nameForSettingForClass:[CountSetting class]]]) > kMaxCount) {
    [self println:[NSString stringWithFormat:@"count must be between -%d and %d", kMaxCount, kMaxCount]];
    returnCode = WryErrorCodeBadInput;
  } else {
    NSString *formatterName = [self.settings stringValue:[WryUtils nameForSettingForClass:[FormatSetting class]]];
    self.formatter = [WryUtils formatterForName:formatterName];
    if (self.formatter == nil) {
      [self println:[NSString stringWithFormat:@"%@: '%@' is not a %@ format. See '%@ help'.", self.appName,
                                               formatterName, self.appName, self.appName]];
      returnCode = WryErrorCodeBadInput;
    } else {
      id <WryCommand> wryCommand = [WryUtils commandForName:self.commandName];
      if (wryCommand == nil) {
        [self println:[NSString stringWithFormat:@"%@: '%@' is not a %@ command. See '%@ help'.", self.appName,
                                                 self.commandName, self.appName, self.appName]];
        returnCode = WryErrorCodeBadInput;
      } else {
        NSError *error;
        if (![wryCommand run:self.params error:&error]) {
          if (error != nil) {
            [self println:error.localizedDescription];
            returnCode = (int) error.code;
          } else {
            returnCode = WryErrorCodeUnknown;
          }
        }
      }
    }
  }
  return returnCode;
}

- (void)print:(NSString *)output {
  if (![self.settings boolValue:[WryUtils nameForSettingForClass:[QuietSetting class]]]) {
    printf("%s", [output UTF8String]);
  }
}

- (void)println:(NSObject *)output {
  [self print:[NSString stringWithFormat:@"%@\n", [output description]]];
}

- (NSString *)getInput {
  char buffer[kInputBufferSize];
  fgets(buffer, kInputBufferSize, stdin);
  return [[NSString stringWithUTF8String:buffer] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

- (void)openURL:(NSString *)urlString {
  NSTask *task = [[NSTask alloc] init];
  task.launchPath = @"/usr/bin/open";
  task.arguments = @[urlString];
  [task launch];
}

- (NSString *)accessToken {
  return [SSKeychain passwordForService:self.appName account:[self.settings stringValue:[WryUtils nameForSettingForClass:[UserSetting class]]]];
}

- (void)setAccessToken:(NSString *)accessToken {
  NSString *user = [self.settings stringValue:[WryUtils nameForSettingForClass:[UserSetting class]]];
  [SSKeychain setPassword:accessToken forService:self.appName
                  account:user];
  if ([SSKeychain accountsForService:self.appName].count == 1) {
    [self.settings setObject:user forKey:[WryUtils nameForSettingForClass:[UserSetting class]]];
  }
}

- (NSString *)version {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)errorDomain {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
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
