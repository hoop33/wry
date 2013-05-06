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
#import "ADNPost.h"
#import "ADNFile.h"
#import "ADNMessage.h"

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

+ (RWJSONMapping *)postMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNPost class]];
  [mapping addAttributeMappingsFromArray:@[@"text"]];
  [mapping addAttributeMappingsFromDictionary:@{
    @"id" : @"postID",
    @"created_at" : @"createdAt"
  }];
  [mapping addRelationshipMappingsWithSourceKeyPath:@"user" mapping:[ADNMappingProvider userMapping]];
  return mapping;
}

+ (RWJSONMapping *)fileMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNFile class]];
  [mapping addAttributeMappingsFromArray:@[@"name", @"sha1"]];
  [mapping addAttributeMappingsFromDictionary:@{
    @"id" : @"fileID",
    @"total_size" : @"totalSize",
    @"created_at" : @"createdAt"
  }];
  return mapping;
}

+ (RWJSONMapping *)messageMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNMessage class]];
  [mapping addAttributeMappingsFromArray:@[@"text"]];
  [mapping addAttributeMappingsFromDictionary:@{
    @"id" : @"messageID",
    @"channel_id" : @"channelID",
    @"thread_id" : @"rootMessageID",
    @"reply_to" : @"replyToID",
    @"created_at" : @"createdAt"
  }];
  [mapping addRelationshipMappingsWithSourceKeyPath:@"user" mapping:[ADNMappingProvider userMapping]];
  return mapping;
}

@end
