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
#import "linenoise.h"
#import "WryUtils.h"

#pragma mark - linenoise

NSArray *commandNames;
NSArray *settingsNames;
NSArray *formatterNames;
void completion(const char *buf, linenoiseCompletions *lc) {
  // Get the whole command line so far
  NSString *cli = [NSString stringWithUTF8String:buf];

  // Figure out the current token (the one they're typing on)
  NSArray *tokens = [cli componentsSeparatedByString:@" "];
  NSString *currentToken = [tokens lastObject];

  // Store the rest of the line
  NSString *rest = [cli substringToIndex:(cli.length - currentToken.length)];

  NSArray *arrayToSearch = nil;

  // Are they typing a formatter?
  if ([rest hasSuffix:@"--format "] || [rest hasSuffix:@"-f "]) {
    arrayToSearch = formatterNames;

  // Are they typing a setting?
  } else if ([currentToken hasPrefix:@"-"]) {
    arrayToSearch = settingsNames;
    rest = [rest stringByAppendingString:@"--"];

  // Are they typing a command?
  } else {
    arrayToSearch = commandNames;
  }

  // Add the completions
  NSString *bareToken = [currentToken stringByReplacingOccurrencesOfString:@"-" withString:@""];
  NSArray *candidates = bareToken.length == 0 ? arrayToSearch :
    [arrayToSearch filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"description beginswith %@", bareToken]];
  for (NSString *completion in candidates) {
    linenoiseAddCompletion(lc, [[NSString stringWithFormat:@"%@%@", rest, completion] UTF8String]);
  }
}

@implementation ShellCommand

- (id)init {
  self = [super init];
  if (self != nil) {
    [self setUpCommandNames];
    [self setUpSettingsNames];
    [self setUpFormatterNames];
  }
  return self;
}

- (void)setUpCommandNames {
  NSArray *commands = [WryUtils allCommands];
  NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[commands count]];
  for (id<WryCommand> command in commands) {
    // Don't add the 'shell' command to the list of commands
    if ([self class] != [command class]) {
      [temp addObject:[WryUtils nameForCommand:command]];
    }
  }
  commandNames = [NSArray arrayWithArray:temp];
}

- (void)setUpSettingsNames {
  NSArray *settings = [WryUtils allSettings];
  NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[settings count]];
  for (id<WrySetting> setting in settings) {
    [temp addObject:[WryUtils nameForSetting:setting]];
  }
  settingsNames = [NSArray arrayWithArray:temp];
}

- (void)setUpFormatterNames {
  NSArray *formatters = [WryUtils allFormatters];
  NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[formatters count]];
  for (id<WryFormatter> formatter in formatters) {
    [temp addObject:[WryUtils nameForFormatter:formatter]];
  }
  formatterNames = [NSArray arrayWithArray:temp];
}

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {

  const char *historyFile = [[WryUtils infoPath:@"history.txt" error:error] UTF8String];
  linenoiseHistorySetMaxLen(1000); // TODO make a setting
  linenoiseSetCompletionCallback(completion);

  char *line;
  while ((line = linenoise([[self prompt] UTF8String])) != NULL) {
    NSString *input = [NSString stringWithUTF8String:line];
    if ([@[@"quit", @"exit"] containsObject:[input lowercaseString]]) {
      break;
    } else {
      WryCommandLine *commandLine = [[WryCommandLine alloc] init];
      if ([commandLine parseString:input error:error]) {
        // No shells in shell
        if ([commandLine.commandName isEqualToString:[WryUtils nameForCommand:self]]) {
          [[WryApplication application] println:@"That would make turtles all the way down."];
        } else {
          linenoiseHistoryAdd(line);
          linenoiseHistorySave(historyFile);
          [commandLine run];
        }
      } else {
        if (error != NULL) {
          [[WryApplication application] println:[*error localizedDescription]];
        }
      }
    }
    free(line);
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
