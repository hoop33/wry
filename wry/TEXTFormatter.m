//
//  TEXTFormatter.m
//  wry
//
//  Created by Rob Warner on 4/6/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "TEXTFormatter.h"

@implementation TEXTFormatter

- (NSString *)format:(ADNResponse *)response {
  NSMutableString *string = [NSMutableString string];
  if ([response.object isKindOfClass:[NSArray class]]) {
    for (id item in (NSArray *) response.object) {
      [string appendString:[NSString stringWithFormat:@"%@\n", [item description]]];
    }
  } else {
    [string appendString:[response.object description]];
  }
  return string;
}

- (NSString *)summary {
  return @"A human-optimized text format";
}

@end
