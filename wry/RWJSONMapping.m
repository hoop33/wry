//
//  RWJSONMapping.m
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RWJSONMapping.h"

@implementation RWJSONMapping

- (id)initWithClass:(Class)cls {
  self = [super init];
  if (self != nil) {
    self.cls = cls;
    self.arrayMappings = [NSMutableArray array];
    self.dictionaryMappings = [NSMutableDictionary dictionary];
    self.relationshipMappings = [NSMutableDictionary dictionary];
    self.listMappings = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)addAttributeMappingsFromArray:(NSArray *)array {
  [self.arrayMappings addObjectsFromArray:array];
}

- (void)addAttributeMappingsFromDictionary:(NSDictionary *)dictionary {
  [self.dictionaryMappings addEntriesFromDictionary:dictionary];
}

- (void)addRelationshipMappingWithSourceKeyPath:(NSString *)sourceKey mapping:(RWJSONMapping *)mapping {
  [self.relationshipMappings setValue:mapping forKey:sourceKey];
}

- (void)addListMappingWithSourceKeyPath:(NSString *)sourceKey mapping:(RWJSONMapping *)mapping {
  [[self listMappings] setValue:mapping forKey:sourceKey];
}

@end
