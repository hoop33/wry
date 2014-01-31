//
//  TEXTFormatter.m
//  wry
//
//  Created by Rob Warner on 4/6/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "TEXTFormatter.h"
#import "WryApplication.h"
#import "BaseSetting.h"

@implementation TEXTFormatter

- (NSString *)format:(ADNResponse *)response {
  BOOL inColor = [WryApplication application].interactiveOut;
  NSMutableString *string = [NSMutableString string];
  if ([response.object isKindOfClass:[NSArray class]]) {
    NSArray *items = (NSArray *) response.object;
    NSUInteger count = items.count;
    [string appendFormat:@"%lu item%@ (%ld - %ld)\n", (unsigned long) count, (count == 1 ? @"" : @"s"), (long) ((ADNObject *)items[count - 1]).paginationID, (long) ((ADNObject *)items[0]).paginationID];
    for (id item in (NSArray *) response.object) {
      [string appendFormat:@"%@\n", inColor && [item respondsToSelector:@selector(colorDescription)] ? [item colorDescription] : [item description]];
    }
  } else {
    [string appendString: inColor && [response.object respondsToSelector:@selector(colorDescription)] ? [response.object colorDescription] : [response.object description]];
  }
  return string;
}

- (NSString *)summary {
  return @"A human-optimized text format";
}

@end
