//
//  HelpCommand.m
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "HelpCommand.h"

@implementation HelpCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  if (params.count == 0) {
    [app println:[NSString stringWithFormat:@"usage: %@ <command> [<params>]", app.appName]];
    [app println:@""];
    [app println:[NSString stringWithFormat:@"The %@ commands are:", app.appName]];
    for (Class cls in [app allCommands]) {
      id<WryCommand> command = [[cls alloc] init];
      // TODO go through app println but with fieldwidth
      printf("%-15s%s\n", [[app nameForCommand:command] UTF8String], [[command summary] UTF8String]);
    }
  }
  else {
    // Get the command
    // Show the help
  }
  return YES;
}

- (NSString *)help {
  return @"This is help for the help command";
}

- (NSString *)summary {
  return @"Shows help";
}

@end
