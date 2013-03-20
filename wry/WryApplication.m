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

#define kVersion @"0.1"
#define kErrorDomain @"com.grailbox.wry"
#define kDefaultCount 20
#define kDefaultCommandName @"HelpCommand"
#define kInputBufferSize 512

@interface WryApplication ()
- (NSString *)getCommandName;

- (id <WryCommand>)getCommand;
@end

@implementation WryApplication

- (id)init {
  self = [super init];
  if (self != nil) {
    self.quiet = NO;
    self.count = kDefaultCount;
  }
  return self;
}

- (int)run {
  int returnCode = WrySuccessCode;
  id <WryCommand> wryCommand = [self getCommand];
  NSError *error;
  if (![wryCommand run:self params:self.params error:&error]) {
    if (error != nil) {
      [self println:error.localizedDescription];
      returnCode = (int) error.code;
    } else {
      returnCode = WryErrorCodeUnknown;
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
  // TODO use actual user name
  return [SSKeychain passwordForService:self.appName account:@"default"];
}

- (void)setAccessToken:(NSString *)accessToken {
  // TODO use actual user name
  [SSKeychain setPassword:accessToken forService:self.appName
                  account:@"default"];
}

- (NSString *)version {
  return kVersion;
}

- (NSString *)errorDomain {
  return kErrorDomain;
}

- (NSString *)helpLine {
  return [NSString stringWithFormat:@"%@ %@", self.appName, [self version]];
}

- (id <WryCommand>)getCommand {
  Class cls = NSClassFromString([self getCommandName]);
  if (cls == nil || ![cls conformsToProtocol:@protocol(WryCommand)]) {
    cls = NSClassFromString(kDefaultCommandName);
  }
  id <WryCommand> wryCommand = [[cls alloc] init];
  return wryCommand;
}

- (NSString *)getCommandName {
  return [NSString stringWithFormat:@"%@Command", [self.command capitalizedString]];
}

@end
