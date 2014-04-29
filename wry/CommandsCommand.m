//
//  CommandsCommand.m
//  wry
//
//  Created by Rob Warner on 4/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "CommandsCommand.h"
#import "WryUtils.h"

@implementation CommandsCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  ADNResponse *response = [[ADNResponse alloc] initWithData:nil mapping:nil reverse:NO error:error];
  NSArray *commandsClasses = [WryUtils allCommands];
  NSMutableArray *commands = [[NSMutableArray alloc] initWithCapacity:commandsClasses.count];
  for (Class cls in commandsClasses) {
    [commands addObject:[[cls alloc] init]];
  }
  response.object = commands;
  WryApplication *app = [WryApplication application];
  [app println:[app.formatter format:response]];
  return YES;
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Lists all the available commands.";
}

- (NSString *)summary {
  return @"List available commands";
}

@end
