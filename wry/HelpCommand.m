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
#import "CommandsCommand.h"
#import "SettingsCommand.h"
#import "FormattersCommand.h"

@interface HelpCommand ()
- (void)showAllHelp;

- (BOOL)showHelpForParam:(NSString *)param;
@end

@implementation HelpCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  BOOL success = YES;
  if (params.count == 0) {
    [self showAllHelp];
  }
  else {
    if (![self showHelpForParam:params[0]]) {
      if (error != NULL) {
        WryApplication *app = [WryApplication application];
        *error = [NSError errorWithDomain:app.errorDomain
                                     code:WryErrorCodeBadInput
                                 userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ is not a valid %@ command, formatter, or setting.",
                                                                                                   params[0],
                                                                                                   app.appName]}];
      }
      success = NO;
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

#pragma mark - Private methods

- (void)showAllHelp {
  WryApplication *app = [WryApplication application];
  [app println:[NSString stringWithFormat:@"usage: %@ [settings] <command> [<args>]",
                                          app.appName]];
  [app println:@""];

  id <WryFormatter> formatter = [WryUtils formatterForName:@"text"];

  // Show the settings
  [app println:[NSString stringWithFormat:@"The %@ settings are:", app.appName]];
  SettingsCommand *settingsCommand = [[SettingsCommand alloc] init];
  [settingsCommand run:nil formatter:formatter options:nil error:nil];

  // Show the formatters
  [app println:[NSString stringWithFormat:@"The %@ formats are:", app.appName]];
  FormattersCommand *formattersCommand = [[FormattersCommand alloc] init];
  [formattersCommand run:nil formatter:formatter options:nil error:nil];

  // Show the commands
  [app println:[NSString stringWithFormat:@"The %@ commands are:", app.appName]];
  CommandsCommand *commandsCommand = [[CommandsCommand alloc] init];
  [commandsCommand run:nil formatter:formatter options:nil error:nil];

  [app println:[NSString stringWithFormat:@"See '%@ help <command | formatter | setting>' for help on a specific\n"
                                            @"command, formatter, or setting.",
                                          app.appName]];
}

- (BOOL)showHelpForParam:(NSString *)param {
  return [self showHelpForInstance:[WryUtils commandForName:param]] |
    [self showHelpForInstance:[WryUtils settingForName:param]] |
    [self showHelpForInstance:[WryUtils formatterForName:param]];
}

- (BOOL)showHelpForInstance:(id)instance {
  BOOL success = NO;
  if (instance != nil) {
    WryApplication *app = [WryApplication application];
    if ([instance conformsToProtocol:@protocol(WryCommand)]) {
      NSString *name = [WryUtils nameForCommand:instance];
      [app println:[NSString stringWithFormat:@"\nHelp for command \"%@\"", name]];
      [app println:[instance description]];
      [app println:[NSString stringWithFormat:@"   usage:      %@ %@ %@", app.appName, name, [instance usage]]];
      [app println:@""];
      [app println:[instance help]];
    } else if ([instance conformsToProtocol:@protocol(WrySetting)]) {
      NSString *name = [WryUtils nameForSetting:instance];
      [app println:[NSString stringWithFormat:@"\nHelp for setting \"%@\"", name]];
      [app println:[instance description]];
      [app println:@""];
      [app print:[NSString stringWithFormat:@"options: "]];
      NSMutableString *allowed = [NSMutableString string];
      for (NSObject *object in [instance allowedValues]) {
        [allowed appendFormat:@", %@", object];
      }
      if (allowed.length > 0) {
        [app println:[allowed substringFromIndex:2]];
      } else {
        [app println:[NSString stringWithFormat:@"<%@>", name]];
      }
      [app println:@""];
      [app println:[instance help]];
    } else if ([instance conformsToProtocol:@protocol(WryFormatter)]) {
      NSString *name = [WryUtils nameForFormatter:instance];
      [app println:[NSString stringWithFormat:@"\nHelp for formatter \"%@\"", name]];
      [app println:[instance description]];
      [app println:@""];
    }
    success = YES;
  }
  return success;
}

@end
