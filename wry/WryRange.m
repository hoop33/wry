//
//  WryRange.m
//  wry
//
//  Created by Rob Warner on 8/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryRange.h"

@implementation WryRange

- (id)initWithRange:(NSRange)range {
  self = [super init];
  if (self != nil) {
    self.from = range.location;
    self.to = range.length;
  }
  return self;
}

- (id)initWithFrom:(int)from to:(int)to {
  self = [super init];
  if (self != nil) {
    self.from = from;
    self.to = to;
  }
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"%d - %d", self.from, self.to];
}

@end
