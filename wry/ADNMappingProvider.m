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
#import "ADNChannel.h"
#import "ADNAnnotation.h"
#import "ADNAccessControlList.h"

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
  [mapping addRelationshipMappingWithSourceKeyPath:@"description" mapping:[ADNMappingProvider userDescriptionMapping]];
  [mapping addListMappingWithSourceKeyPath:@"annotations" mapping:[ADNMappingProvider annotationMapping]];
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
  [mapping addRelationshipMappingWithSourceKeyPath:@"user" mapping:[ADNMappingProvider userMapping]];
  [mapping addListMappingWithSourceKeyPath:@"annotations" mapping:[ADNMappingProvider annotationMapping]];
  return mapping;
}

+ (RWJSONMapping *)fileMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNFile class]];
  [mapping addAttributeMappingsFromArray:@[@"name", @"sha1", @"url"]];
  [mapping addAttributeMappingsFromDictionary:@{
    @"id" : @"fileID",
    @"total_size" : @"totalSize",
    @"created_at" : @"createdAt",
    @"url_short" : @"shortUrl",
    @"public" : @"isPublic"
  }];
  [mapping addListMappingWithSourceKeyPath:@"annotations" mapping:[ADNMappingProvider annotationMapping]];
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
  [mapping addRelationshipMappingWithSourceKeyPath:@"user" mapping:[ADNMappingProvider userMapping]];
  [mapping addListMappingWithSourceKeyPath:@"annotations" mapping:[ADNMappingProvider annotationMapping]];
  return mapping;
}

+ (RWJSONMapping *)channelMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNChannel class]];
  [mapping addAttributeMappingsFromArray:@[@"type"]];
  [mapping addAttributeMappingsFromDictionary:@{
    @"id" : @"channelID",
    @"you_muted" : @"muted",
    @"you_subscribed" : @"subscribed",
    @"you_can_edit" : @"edit"
  }];
  [mapping addRelationshipMappingWithSourceKeyPath:@"owner" mapping:[ADNMappingProvider userMapping]];
  [mapping addRelationshipMappingWithSourceKeyPath:@"readers" mapping:[ADNMappingProvider accessControlListMapping]];
  [mapping addRelationshipMappingWithSourceKeyPath:@"writers" mapping:[ADNMappingProvider accessControlListMapping]];
  [mapping addListMappingWithSourceKeyPath:@"annotations" mapping:[ADNMappingProvider annotationMapping]];
  return mapping;
}

+ (RWJSONMapping *)annotationMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNAnnotation class]];
  [mapping addAttributeMappingsFromArray:@[@"type", @"value"]];
  return mapping;
}

+ (RWJSONMapping *)accessControlListMapping {
  RWJSONMapping *mapping = [[RWJSONMapping alloc] initWithClass:[ADNAccessControlList class]];
  [mapping addAttributeMappingsFromArray:@[@"immutable", @"public", @"you"]];
  [mapping addAttributeMappingsFromDictionary:@{
    @"any_user" : @"anyUser",
    @"user_ids" : @"userIDs"
  }];
  return mapping;
}

@end
