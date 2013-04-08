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

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNResponse *response = [[ADNResponse alloc] initWithData:nil];
  response.object = [WryUtils allCommands];
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
  return @"Lists available commands";
}

@end
