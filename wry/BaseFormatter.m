//
//  BaseFormatter.m
//  wry
//
//  Created by Rob Warner on 9/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "BaseFormatter.h"
#import "WryFormatter.h"
#import "WryUtils.h"

@implementation BaseFormatter

- (NSString *)description {
  if ([self conformsToProtocol:@protocol(WryFormatter)]) {
    id <WryFormatter> this = (id <WryFormatter>) self;
    return [NSString stringWithFormat:@"   %-12s%@", [[WryUtils nameForFormatter:this] UTF8String], [this summary]];
  } else {
    return [super description];
  }
}

@end
