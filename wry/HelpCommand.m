//
//  HelpCommand.m
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "HelpCommand.h"
#import "WryErrorCodes.h"

@implementation HelpCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  BOOL success = YES;
  if (params.count == 0) {
    [app println:[NSString stringWithFormat:@"usage: %@ <command> [<params>]", app.appName]];
    [app println:@""];
    [app println:[NSString stringWithFormat:@"The %@ commands are:", app.appName]];
    for (Class cls in [app allCommands]) {
      id <WryCommand> command = [[cls alloc] init];
      // TODO go through app println but with fieldwidth
      printf("   %-12s%s\n", [[app nameForCommand:command] UTF8String], [[command summary] UTF8String]);
    }
    [app println:@""];
    [app println:[NSString stringWithFormat:@"See '%@ help <command>' for more information on a specific command.",
                                            app.appName]];
  }
  else {
    id <WryCommand> command = [app commandForName:[params objectAtIndex:0]];
    if (command == nil) {
      if (error != NULL) {
        *error = [NSError errorWithDomain:app.errorDomain
                                     code:WryErrorCodeBadInput
                                 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ is not a valid %@ command",
                                                                                                   [params objectAtIndex:0],
                                                                                                   app.appName]}];
      }
      success = NO;
    } else {
      [app println:[command help]];
    }
  }
  return success;
}

- (NSString *)help {
  return @"This is help for the help command";
}

- (NSString *)summary {
  return @"Display help";
}

@end
