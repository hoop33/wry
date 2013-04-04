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
    [app println:[NSString stringWithFormat:@"usage: %@ [--count n] [--debug] [--quiet] <command> [<args>]", app.appName]];
    [app println:@""];
    [app println:@"   -c, --count: For commands that return multiple items, return up to n items."];
    [app println:@"   -d, --debug: Show debugging information."];
    [app println:@"   -q, --quiet: Mute all output."];
    [app println:@""];
    [app println:[NSString stringWithFormat:@"The %@ commands are:", app.appName]];
    for (Class cls in [app allCommands]) {
      id <WryCommand> command = [[cls alloc] init];
      [app println:[NSString stringWithFormat:@"   %-12s%@", [[app nameForCommand:command]
                                                                   UTF8String], [command summary]]];
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
      [app println:[NSString stringWithFormat:@"usage: %@ %@ %@", app.appName, [app nameForCommand:command],
                                              [command usage]]];
      [app println:@""];
      [app println:[command help]];
    }
  }
  return success;
}

- (NSString *)usage {
  return @"[command]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Displays help. If you specify a command, displays help for that command.\n"];
  [help appendString:@"Otherwise, displays a summary of help."];
  return help;
}

- (NSString *)summary {
  return @"Display help";
}

@end
