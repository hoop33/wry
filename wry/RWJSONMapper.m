//
//  RWJSONMapper.m
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RWJSONMapper.h"
#import "RWJSONMapping.h"

@implementation RWJSONMapper

+ (id)mapObjectFromData:(NSData *)data mapping:(RWJSONMapping *)mapping {
  NSLog(@"Doing the mapping");
  NSError *error;
  id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions
                                              error:&error];
  if (jsonObject != nil) {
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
      // Single object; map it
      NSObject *object = [RWJSONMapper mapObjectFromDictionary:jsonObject
                                                       mapping:mapping];
      NSLog(@"The object is %@", object);
    }
  } else {
    NSLog(@"Error: %@", [error localizedDescription]);
  }
  return nil;
}

+ (NSObject *)mapObjectFromDictionary:(NSDictionary *)dictionary mapping:(RWJSONMapping *)mapping {
  NSObject* object = [[mapping.cls alloc] init];
  for (NSString *key in [dictionary allKeys]) {
    if ([mapping.arrayMappings containsObject:key]) {
      [object setValue:[dictionary valueForKey:key] forKey:key];
    } else if ([[mapping.dictionaryMappings allKeys] containsObject:key]) {
      [object setValue:[dictionary valueForKey:key] forKey:[mapping.dictionaryMappings valueForKey:key]];
    }
  }
  return object;
}

@end
