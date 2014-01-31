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
    [string appendFormat:@"%lu items (%ld - %ld)\n", (unsigned long) items.count, (long) ((ADNObject *)items[items.count - 1]).objectID, (long) ((ADNObject *)items[0]).objectID];
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
