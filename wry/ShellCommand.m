//
//  ShellCommand.m
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "ShellCommand.h"
#import "WryCommandLine.h"
#import "WrySettings.h"

#define kMaxLength 1024

@implementation ShellCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  char cli[kMaxLength];
  BOOL quit = false;
  while (!quit) {
    [[WryApplication application] print:[self prompt]];

    fgets(cli, sizeof(cli), stdin);
    NSString *enteredText = [[NSString stringWithUTF8String:cli] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ([@[@"quit", @"exit"] containsObject:[enteredText lowercaseString]]) {
      quit = YES;
    } else {
      WryCommandLine *commandLine = [[WryCommandLine alloc] init];
      if ([commandLine parseString:enteredText error:error]) {
        [commandLine run];
      } else {
        if (error != NULL) {
          [[WryApplication application] println:[*error localizedDescription]];
        }
      }
    }
  }
  return NO;
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return [NSString stringWithFormat:@"Runs a shell for running %@ commands.", [WryApplication application].appName];
}

- (NSString *)summary {
  return [NSString stringWithFormat:@"Run a %@ shell", [WryApplication application].appName];
}

- (NSString *)prompt {
  return [NSString stringWithFormat:@"%@@%@ => ", [[WryApplication application].settings defaultUser], [WryApplication application].appName];
}

@end
