//
//  NSDictionary+JSONMapping.m
//  wry
//
//  Created by Rob Warner on 3/15/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "NSDictionary+JSONMapping.h"
#import "ADNJSONMapping.h"
#import "ADNMappingEntry.h"

@implementation NSDictionary (JSONMapping)

- (NSObject *)mapToObjectWithMapping:(ADNJSONMapping *)mapping {
  NSObject *object = [[mapping.cls alloc] init];
  for (ADNMappingEntry *entry in mapping.entries) {
    id value = [self valueForKeyPath:entry.from];
    if (value != nil) {
      if ([value isKindOfClass:[NSArray class]]) {
        NSMutableArray *values = [NSMutableArray array];
        for (id item in value) {
          [values addObject:(entry.mapping == nil ? item : [(NSDictionary *)item mapToObjectWithMapping:entry.mapping])];
        }
        [object setValue:values forKey:entry.to];
      } else if (entry.mapping != nil) {
        [object setValue:[(NSDictionary *) value mapToObjectWithMapping:entry.mapping] forKey:entry.to];
      } else {
        [object setValue:value forKey:entry.to];
      }
    }
  }
  return object;
}

@end
