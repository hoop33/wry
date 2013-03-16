//
//  ADNMappingProvider.m
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNMappingProvider.h"
#import "RWJSONMapping.h"
#import "ADNUser.h"
#import "ADNUserDescription.h"

@implementation ADNMappingProvider

+ (RWJSONMapping *)adnWrapperMapping {
  return nil;
}

+ (RWJSONMapping *)userMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNUser class]];
  [mapping addAttributeMappingsFromArray:
             @[@"username", @"name"]];
  [mapping addAttributeMappingsFromDictionary:@{
    @"id" : @"userID",
    @"description" : @"userDescription",
    @"follows_you" : @"followsYou",
    @"you_follow" : @"youFollow"
  }];
  [mapping addRelationshipMappingsWithSourceKeyPath:@"description" mapping:[ADNMappingProvider userDescriptionMapping]];
  return mapping;
}

+ (RWJSONMapping *)userDescriptionMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNUserDescription class]];
  [mapping addAttributeMappingsFromArray:
             @[@"text"]];
  return mapping;
}

@end
