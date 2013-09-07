//
//  BaseCommand.m
//  wry
//
//  Created by Rob Warner on 9/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "BaseCommand.h"
#import "WryUtils.h"

@implementation BaseCommand

- (NSString *)description {
  if ([self conformsToProtocol:@protocol(WryCommand)]) {
    id<WryCommand> this = (id<WryCommand>)self;
    return [NSString stringWithFormat:@"%-12s%@", [[WryUtils nameForCommand:this] UTF8String], [this summary]];
  } else {
    return [self description];
  }
}

@end
