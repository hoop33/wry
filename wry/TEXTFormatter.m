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
    [string appendFormat:@"%@\n", [self rangeString:items]];
    for (id item in (NSArray *) response.object) {
      [string appendFormat:@"%@\n", inColor && [item respondsToSelector:@selector(colorDescription)] ? [item colorDescription] : [item description]];
    }
  } else if (response.object != nil) {
    [string appendString: inColor && [response.object respondsToSelector:@selector(colorDescription)] ? [response.object colorDescription] : [response.object description]];
  }
  return string;
}

- (NSString *)rangeString:(NSArray *)items {
  NSUInteger count = items.count;
  switch (count) {
    case 0:
      return @"";
    case 1:
      return [NSString stringWithFormat:@"1 item (%ld)", (long) ((ADNObject *)items[0]).paginationID];
    default:
      return [NSString stringWithFormat:@"%lu items (%ld - %ld)", (unsigned long) count, (long) ((ADNObject *)items[count - 1]).paginationID, (long) ((ADNObject *)items[0]).paginationID];
  }
}

- (NSString *)summary {
  return @"A human-optimized text format";
}

@end
