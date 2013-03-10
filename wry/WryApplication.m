//
//  WryApplication.m
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "WryCommand.h"

#define kDefaultCommandName @"AboutCommand"

@interface WryApplication ()
- (NSString *)getCommandName;
- (id<WryCommand>)getCommand;
@end

@implementation WryApplication

- (int)run
{
  id<WryCommand> wryCommand = [self getCommand];
  return [wryCommand run:self.params];
}

- (id<WryCommand>)getCommand
{
  Class cls = NSClassFromString([self getCommandName]);
  if (cls == nil || ![cls conformsToProtocol:@protocol(WryCommand)])
  {
    cls = NSClassFromString(kDefaultCommandName);
  }
  id<WryCommand> wryCommand = [[cls alloc] init];
  return wryCommand;
}

- (NSString *)getCommandName
{
  return [NSString stringWithFormat:@"%@Command", [self.command capitalizedString]];
}

@end
