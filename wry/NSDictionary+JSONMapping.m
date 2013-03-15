//
//  NSDictionary+JSONMapping.m
//  wry
//
//  Created by Rob Warner on 3/15/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "NSDictionary+JSONMapping.h"
#import "RWJSONMapping.h"

@implementation NSDictionary (JSONMapping)

- (NSObject *)mapToObjectWithMapping:(RWJSONMapping *)mapping {
  NSObject *object = [[mapping.cls alloc] init];
  for (NSString *key in [self allKeys]) {
    if ([mapping.arrayMappings containsObject:key]) {
      [object setValue:[self valueForKey:key] forKey:key];
    } else if ([[mapping.dictionaryMappings allKeys] containsObject:key]) {
      [object setValue:[self valueForKey:key] forKey:[mapping.dictionaryMappings valueForKey:key]];
    }
  }
  return object;
}

@end
