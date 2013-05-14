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
    // Get the key for the destination object
    NSString *toKey = [[mapping.dictionaryMappings allKeys] containsObject:key] ?
      [mapping.dictionaryMappings valueForKey:key] : key;

    if ([mapping.arrayMappings containsObject:key]) {
      // Map the straight mappings
      [object setValue:[self valueForKey:key] forKey:key];
    } else if ([[mapping.relationshipMappings allKeys] containsObject:key]) {
      // Map the relationships
      NSDictionary *dictionary = [self valueForKey:key];
      [object setValue:[dictionary mapToObjectWithMapping:[mapping.relationshipMappings valueForKey:key]] forKey:toKey];
    } else if ([[mapping.listMappings allKeys] containsObject:key]) {
      // Map the lists
      NSArray *array = [self valueForKey:key];
      NSMutableArray *destination = [NSMutableArray array];
      for (NSDictionary *item in array) {
        [destination addObject:[item mapToObjectWithMapping:[mapping.listMappings valueForKey:key]]];
      }
      [object setValue:destination forKey:toKey];
    } else if ([[mapping.dictionaryMappings allKeys] containsObject:key]) {
      // Map the translations
      [object setValue:[self valueForKey:key] forKey:[mapping.dictionaryMappings valueForKey:key]];
    }
  }
  return object;
}

@end
