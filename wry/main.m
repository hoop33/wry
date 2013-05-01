//
//  main.m
//  wry
//
//  Created by Rob Warner on 3/8/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "WryErrorCodes.h"
#import "NSString+Atification.h"

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    WryApplication *application = [[WryApplication alloc] init];
    application.appName = [[NSString stringWithUTF8String:argv[0]] lastPathComponent];

    NSString *errorMessage = nil;
    NSMutableArray *params = [NSMutableArray array];
    // TODO clean up this ugly code
    for (int i = 1; i < argc; i++) {
      NSString *param = [NSString stringWithUTF8String:argv[i]];
      if ([param hasPrefix:@"-"]) {
        if ([@[@"-d", @"--debug"] containsObject:param]) {
          application.debug = YES;
        } else if ([@[@"-q", @"--quiet"] containsObject:param]) {
          application.quiet = YES;
        } else if ([@[@"-p", @"--pretty"] containsObject:param]) {
          application.pretty = YES;
        } else if ([@[@"-c", @"--count"] containsObject:param]) {
          ++i;
          if (i >= argc) {
            errorMessage = [NSString stringWithFormat:@"You must specify a count when passing %@", param];
            break;
          } else {
            application.count = [[NSString stringWithUTF8String:argv[i]] intValue];
          }
        } else if ([@[@"-f", @"--format"] containsObject:param]) {
          ++i;
          if (i >= argc) {
            errorMessage = [NSString stringWithFormat:@"You must specify a format when passing %@", param];
            break;
          } else {
            application.format = [NSString stringWithUTF8String:argv[i]];
          }
        } else if ([@[@"-u", @"--user"] containsObject:param]) {
          ++i;
          if (i >= argc) {
            errorMessage = [NSString stringWithFormat:@"You must specify a user when passing %@", param];
            break;
          } else {
            application.user = [[NSString stringWithUTF8String:argv[i]] deatify];
          }
        } else {
          errorMessage = [NSString stringWithFormat:@"Unknown flag: %@", param];
          break;
        }
      } else if (application.commandName == nil) {
        application.commandName = param;
      } else {
        [params addObject:param];
      }
    }
    if (errorMessage != nil) {
      [application println:errorMessage];
      return WryErrorCodeBadInput;
    } else {
      application.params = [NSArray arrayWithArray:params];
      if (application.commandName == nil) {
        application.commandName = @"help";
      }
      return [application run];
    }
  }
}
