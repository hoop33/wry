//
//  WryApplication.m
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "SSKeychain.h"
#import "WryUtils.h"
#import "AnnotationsSetting.h"
#import "QuietSetting.h"
#import "UserSetting.h"

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

- (NSString *)version {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)errorDomain {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

@end
