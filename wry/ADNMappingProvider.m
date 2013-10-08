//
//  ADNMappingProvider.m
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNMappingProvider.h"
#import "ADNJSONMapping.h"
#import "ADNUser.h"
#import "ADNUserDescription.h"
#import "ADNPost.h"
#import "ADNFile.h"
#import "ADNMessage.h"
#import "ADNChannel.h"
#import "ADNAnnotation.h"
#import "ADNAccessControlList.h"
#import "ADNHashtag.h"
#import "ADNLink.h"
#import "ADNMappingEntry.h"
#import "ADNSource.h"

@implementation ADNMappingProvider

+ (ADNJSONMapping *)userMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNUser class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"id" to:@"userID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"description" to:@"userDescription"
                          mapping:[ADNMappingProvider userDescriptionMapping]],
    [ADNMappingEntry mappingEntry:@"follows_you" to:@"followsYou" mapping:nil],
    [ADNMappingEntry mappingEntry:@"you_follow" to:@"youFollow" mapping:nil],
    [ADNMappingEntry mappingEntry:@"username" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"name" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"annotations" to:nil mapping:[ADNMappingProvider annotationMapping]]
  ];
  return mapping;
}

+ (ADNJSONMapping *)userDescriptionMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNUserDescription class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"text" to:nil mapping:nil]
  ];
  return mapping;
}

+ (ADNJSONMapping *)postMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNPost class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"id" to:@"postID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"created_at" to:@"createdAt" mapping:nil],
    [ADNMappingEntry mappingEntry:@"entities.links" to:@"links" mapping:[ADNMappingProvider linkMapping]],
    [ADNMappingEntry mappingEntry:@"entities.hashtags" to:@"hashtags" mapping:[ADNMappingProvider hashtagMapping]],
    [ADNMappingEntry mappingEntry:@"text" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"user" to:nil mapping:[ADNMappingProvider userMapping]],
    [ADNMappingEntry mappingEntry:@"annotations" to:nil mapping:[ADNMappingProvider annotationMapping]],
    [ADNMappingEntry mappingEntry:@"source" to:nil mapping:[ADNMappingProvider sourceMapping]]
  ];
  return mapping;
}

+ (ADNJSONMapping *)fileMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNFile class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"name" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"sha1" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"url" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"id" to:@"fileID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"total_size" to:@"totalSize" mapping:nil],
    [ADNMappingEntry mappingEntry:@"created_at" to:@"createdAt" mapping:nil],
    [ADNMappingEntry mappingEntry:@"url_short" to:@"shortUrl" mapping:nil],
    [ADNMappingEntry mappingEntry:@"public" to:@"isPublic" mapping:nil],
    [ADNMappingEntry mappingEntry:@"annotations" to:nil mapping:[ADNMappingProvider annotationMapping]]
  ];
  return mapping;
}

+ (ADNJSONMapping *)messageMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNMessage class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"text" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"id" to:@"messageID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"channel_id" to:@"channelID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"thread_id" to:@"rootMessageID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"reply_to" to:@"replyToID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"created_at" to:@"createdAt" mapping:nil],
    [ADNMappingEntry mappingEntry:@"user" to:nil mapping:[ADNMappingProvider userMapping]],
    [ADNMappingEntry mappingEntry:@"annotations" to:nil mapping:[ADNMappingProvider annotationMapping]],
    [ADNMappingEntry mappingEntry:@"entities.links" to:@"links" mapping:[ADNMappingProvider linkMapping]],
    [ADNMappingEntry mappingEntry:@"entities.hashtags" to:@"hashtags" mapping:[ADNMappingProvider hashtagMapping]]
  ];
  return mapping;
}

+ (ADNJSONMapping *)channelMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNChannel class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"type" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"id" to:@"channelID" mapping:nil],
    [ADNMappingEntry mappingEntry:@"you_muted" to:@"muted" mapping:nil],
    [ADNMappingEntry mappingEntry:@"you_subscribed" to:@"subscribed" mapping:nil],
    [ADNMappingEntry mappingEntry:@"you_can_edit" to:@"edit" mapping:nil],
    [ADNMappingEntry mappingEntry:@"owner" to:nil mapping:[ADNMappingProvider userMapping]],
    [ADNMappingEntry mappingEntry:@"readers" to:nil mapping:[ADNMappingProvider accessControlListMapping]],
    [ADNMappingEntry mappingEntry:@"writers" to:nil mapping:[ADNMappingProvider accessControlListMapping]],
    [ADNMappingEntry mappingEntry:@"annotations" to:nil mapping:[ADNMappingProvider annotationMapping]]
  ];
  return mapping;
}

+ (ADNJSONMapping *)annotationMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNAnnotation class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"type" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"value" to:nil mapping:nil]
  ];
  return mapping;
}

+ (ADNJSONMapping *)hashtagMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNHashtag class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"name" to:@"text" mapping:nil]
  ];
  return mapping;
}

+ (ADNJSONMapping *)linkMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNLink class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"text" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"url" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"pos" to:@"position" mapping:nil],
    [ADNMappingEntry mappingEntry:@"len" to:@"length" mapping:nil]
  ];
  return mapping;
}

+ (ADNJSONMapping *)accessControlListMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNAccessControlList class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"immutable" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"public" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"you" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"any_user" to:@"anyUser" mapping:nil],
    [ADNMappingEntry mappingEntry:@"user_ids" to:@"userIDs" mapping:nil]
  ];
  return mapping;
}

+ (ADNJSONMapping *)sourceMapping {
  ADNJSONMapping *mapping = [[ADNJSONMapping alloc] initWithClass:[ADNSource class]];
  mapping.entries = @[
    [ADNMappingEntry mappingEntry:@"name" to:nil mapping:nil],
    [ADNMappingEntry mappingEntry:@"link" to:nil mapping:nil]
  ];
  return mapping;
}

@end
