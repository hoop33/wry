//
//  HelpCommand.m
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "HelpCommand.h"

@implementation HelpCommand

- (int)run:(WryApplication *)app params:(NSArray *)params
{
  [app println:[app helpLine]];
  [app println:@"Usage:"];
  [app println:[NSString stringWithFormat:@"%@ <command> <params>", app.appName]];
  return 0;
}

@end
