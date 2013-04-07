//
//  WryApplication.m
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <objc/objc-runtime.h>

#import "WryApplication.h"
#import "WryCommand.h"
#import "WryFormatter.h"
#import "WryErrorCodes.h"
#import "SSKeychain.h"

#define kVersion @"1.2"
#define kErrorDomain @"com.grailbox.wry"
#define kCommandSuffix @"Command"
#define kFormatterSuffix @"Formatter"
#define kDefaultFormat @"text"
#define kDefaultCount 20
#define kMaxCount 200
#define kInputBufferSize 512

@implementation WryApplication

- (id)init {
  self = [super init];
  if (self != nil) {
    self.quiet = NO;
    self.count = kDefaultCount;
    // TODO put this in defaults with a format command to read/set
    self.format = kDefaultFormat;
  }
  return self;
}

- (int)run {
  int returnCode = WrySuccessCode;
  if (abs(self.count) > kMaxCount) {
    [self println:[NSString stringWithFormat:@"count must be between -%d and %d", kMaxCount, kMaxCount]];
    returnCode = WryErrorCodeBadInput;
  } else {
    self.formatter = [self formatterForName:self.format];
    if (self.formatter == nil) {
      [self println:[NSString stringWithFormat:@"%@: '%@' is not a %@ format. See '%@ help'.", self.appName,
                                               self.format, self.appName, self.appName]];
      returnCode = WryErrorCodeBadInput;
    } else {
      id <WryCommand> wryCommand = [self commandForName:self.commandName];
      if (wryCommand == nil) {
        [self println:[NSString stringWithFormat:@"%@: '%@' is not a %@ command. See '%@ help'.", self.appName,
                                                 self.commandName, self.appName, self.appName]];
        returnCode = WryErrorCodeBadInput;
      } else {
        NSError *error;
        if (![wryCommand run:self params:self.params error:&error]) {
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

- (id <WryCommand>)commandForName:(NSString *)name {
  id <WryCommand> wryCommand = nil;
  Class cls = NSClassFromString([NSString stringWithFormat:@"%@%@", [name capitalizedString], kCommandSuffix]);
  if (cls != nil && [cls conformsToProtocol:@protocol(WryCommand)]) {
    wryCommand = [[cls alloc] init];
  }
  return wryCommand;
}

- (NSString *)nameForCommand:(id <WryCommand>)command {
  NSString *string = [[command.class description] lowercaseString];
  return [string substringToIndex:(string.length - kCommandSuffix.length)];
}

- (NSArray *)allCommands {
  NSMutableArray *commands = [NSMutableArray array];
  Class *classes = NULL;
  int numClasses = objc_getClassList(NULL, 0);
  if (numClasses > 0) {
    classes = (__unsafe_unretained Class *) malloc(sizeof(Class) * numClasses);
    int n = objc_getClassList(classes, numClasses);
    for (int i = 0; i < n; i++) {
      Class cls = classes[i];
      NSString *className = [NSString stringWithUTF8String:class_getName(classes[i])];
      if ([className hasSuffix:kCommandSuffix] && [cls conformsToProtocol:@protocol(WryCommand)]) {
        [commands addObject:cls];
      }
    }
    free(classes);
  }
  return [commands sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    NSString *first = [(Class) a description];
    NSString *second = [(Class) b description];
    return [first compare:second];
  }];
}

- (id <WryFormatter>)formatterForName:(NSString *)name {
  id <WryFormatter> wryFormatter = nil;
  Class cls = NSClassFromString([NSString stringWithFormat:@"%@%@", [name uppercaseString], kFormatterSuffix]);
  if (cls != nil && [cls conformsToProtocol:@protocol(WryFormatter)]) {
    wryFormatter = [[cls alloc] init];
  }
  return wryFormatter;
}

- (NSString *)nameForFormatter:(id <WryFormatter>)formatter {
  NSString *string = [[formatter.class description] lowercaseString];
  return [string substringToIndex:(string.length - kFormatterSuffix.length)];
}

- (NSArray *)allFormats {
  NSMutableArray *formats = [NSMutableArray array];
  Class *classes = NULL;
  int numClasses = objc_getClassList(NULL, 0);
  if (numClasses > 0) {
    classes = (__unsafe_unretained Class *) malloc(sizeof(Class) * numClasses);
    int n = objc_getClassList(classes, numClasses);
    for (int i = 0; i < n; i++) {
      Class cls = classes[i];
      NSString *className = [NSString stringWithUTF8String:class_getName(classes[i])];
      if ([className hasSuffix:kFormatterSuffix] && [cls conformsToProtocol:@protocol(WryFormatter)]) {
        [formats addObject:cls];
      }
    }
    free(classes);
  }
  return [formats sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    NSString *first = [(Class) a description];
    NSString *second = [(Class) b description];
    return [first compare:second];
  }];
}
@end
