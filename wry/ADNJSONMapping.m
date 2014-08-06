//
//  ADNJSONMapping.m
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNJSONMapping.h"

@implementation ADNJSONMapping

- (instancetype)initWithClass:(Class)cls {
  self = [super init];
  if (self != nil) {
    _cls = cls;
  }
  return self;
}

@end
