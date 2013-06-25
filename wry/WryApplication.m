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
#import "WrySettings.h"

#define kVersion @"1.6"
#define kErrorDomain @"com.grailbox.wry"
#define kDefaultFormat @"text"
#define kDefaultCount 20
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

- (id)init {
  self = [super init];
  if (self != nil) {
    self.settings = [[WrySettings alloc] init];
    self.quiet = NO;
    self.count = kDefaultCount;
    self.format = kDefaultFormat;
    self.user = self.settings.defaultUser;
  }
  return self;
}

- (int)run {
  int returnCode = WrySuccessCode;
  if (abs(self.count) > kMaxCount) {
    [self println:[NSString stringWithFormat:@"count must be between -%d and %d", kMaxCount, kMaxCount]];
    returnCode = WryErrorCodeBadInput;
  } else {
    self.formatter = [WryUtils formatterForName:self.format];
    if (self.formatter == nil) {
      [self println:[NSString stringWithFormat:@"%@: '%@' is not a %@ format. See '%@ help'.", self.appName,
                                               self.format, self.appName, self.appName]];
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
  if (!self.quiet) {
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
  return [SSKeychain passwordForService:self.appName account:self.user];
}

- (void)setAccessToken:(NSString *)accessToken {
  [SSKeychain setPassword:accessToken forService:self.appName
                  account:self.user];
  if ([SSKeychain accountsForService:self.appName].count == 1) {
    self.settings.defaultUser = self.user;
    [self.settings save];
  }
}

- (NSString *)version {
  return kVersion;
}

- (NSString *)errorDomain {
  return kErrorDomain;
}

@end
