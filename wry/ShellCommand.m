//
//  ShellCommand.m
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "ShellCommand.h"

@implementation ShellCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
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

@end
