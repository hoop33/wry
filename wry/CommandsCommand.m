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
  ADNResponse *response = [[ADNResponse alloc] initWithData:nil];
  response.object = [WryUtils allCommands];
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
