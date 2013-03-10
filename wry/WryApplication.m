//
//  WryApplication.m
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "WryCommand.h"

#define kVersion @"0.1"
#define kDefaultCommandName @"HelpCommand"

@interface WryApplication ()
- (NSString *)getCommandName;
- (id<WryCommand>)getCommand;
@end

@implementation WryApplication

- (int)run
{
  id<WryCommand> wryCommand = [self getCommand];
  return [wryCommand run:self params:self.params];
}

- (void)print:(NSString *)output
{
  printf("%s", [output UTF8String]);
}

- (void)println:(NSString *)output
{
  [self print:[NSString stringWithFormat:@"%@\n", output]];
}

- (NSString *)version
{
  return kVersion;
}

- (NSString *)helpLine
{
  return [NSString stringWithFormat:@"%@ %@", self.appName, [self version]];
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
