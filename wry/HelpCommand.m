//
//  HelpCommand.m
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "HelpCommand.h"
#import "WryErrorCodes.h"
#import "WryFormatter.h"
#import "WryUtils.h"

@implementation HelpCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  BOOL success = YES;
  if (params.count == 0) {
    [app println:[NSString stringWithFormat:@"usage: %@ [flags] <command> [<args>]",
                                            app.appName]];
    [app println:@""];
    [app println:[NSString stringWithFormat:@"The %@ flags are:", app.appName]];
    [app println:@"   -a, --annotations      Include annotations"];
    [app println:@"   -c, --count <n>        Limit count to n items"];
    [app println:@"   -d, --debug            Show debugging information"];
    [app println:@"   -f, --format <format>  Display output in format"];
    [app println:@"   -p, --pretty           Pretty-print the JSON response (for -f json only)"];
    [app println:@"   -q, --quiet            Mute all output"];
    [app println:@"   -r, --reverse          Reverse the order of the output"];
    [app println:@"   -u, --user <user>      Specify the user to use"];
    [app println:@""];
    [app println:[NSString stringWithFormat:@"The %@ formats are:", app.appName]];
    for (Class cls in [WryUtils allFormats]) {
      id <WryFormatter> formatter = [[cls alloc] init];
      [app println:[NSString stringWithFormat:@"   %-12s%@", [[WryUtils nameForFormatter:formatter] UTF8String],
                                              [formatter summary]]];
    }
    [app println:@""];
    [app println:[NSString stringWithFormat:@"The %@ commands are:", app.appName]];
    for (Class cls in [WryUtils allCommands]) {
      id <WryCommand> command = [[cls alloc] init];
      [app println:[NSString stringWithFormat:@"   %-12s%@", [[WryUtils nameForCommand:command]
                                                                        UTF8String], [command summary]]];
    }
    [app println:@""];
    [app println:[NSString stringWithFormat:@"See '%@ help <command>' for more information on a specific command.",
                                            app.appName]];
  }
  else {
    id <WryCommand> command = [WryUtils commandForName:[params objectAtIndex:0]];
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
      [app println:[NSString stringWithFormat:@"usage: %@ %@ %@", app.appName, [WryUtils nameForCommand:command],
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
