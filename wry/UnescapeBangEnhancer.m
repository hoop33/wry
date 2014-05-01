//
//  UnescapeBangEnhancer.m
//  wry
//
//  Created by Rob Warner on 5/1/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "UnescapeBangEnhancer.h"

@implementation UnescapeBangEnhancer

- (id)enhance:(id)object {
  return [object isKindOfClass:[NSString class]] ?
    [(NSString *)object stringByReplacingOccurrencesOfString:@"\\!" withString:@"!"] : object;
}

@end
