//
//  HelpCommand.m
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "HelpCommand.h"

@implementation HelpCommand

- (void)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  [app println:[app helpLine]];
  [app println:@"Usage:"];
  [app println:[NSString stringWithFormat:@"%@ <command> <params>", app.appName]];
}

- (NSString *)help {
  return @"This is help for the help command";
}

@end
