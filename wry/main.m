//
//  main.m
//  wry
//
//  Created by Rob Warner on 3/8/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "WryErrorCodes.h"

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
        if ([param isEqualToString:@"-d"] || [param isEqualToString:@"--debug"]) {
          application.debug = YES;
        } else if ([param isEqualToString:@"-q"] || [param isEqualToString:@"--quiet"]) {
          application.quiet = YES;
        } else if ([param isEqualToString:@"-c"] || [param isEqualToString:@"--count"]) {
          ++i;
          if (i >= argc) {
            errorMessage = [NSString stringWithFormat:@"You must specify a count when passing %@", param];
            break;
          } else {
            application.count = [[NSString stringWithUTF8String:argv[i]] intValue];
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
