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

#define kVersion @"1.7beta1"
#define kErrorDomain @"com.grailbox.wry"
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
  return kVersion;
}

- (NSString *)errorDomain {
  return kErrorDomain;
}

@end
