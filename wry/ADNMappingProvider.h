//
//  ADNMappingProvider.h
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@class ADNJSONMapping;

@interface ADNMappingProvider : NSObject

+ (ADNJSONMapping *)userMapping;
+ (ADNJSONMapping *)userDescriptionMapping;
+ (ADNJSONMapping *)postMapping;
+ (ADNJSONMapping *)fileMapping;
+ (ADNJSONMapping *)messageMapping;
+ (ADNJSONMapping *)channelMapping;
+ (ADNJSONMapping *)annotationMapping;
+ (ADNJSONMapping *)accessControlListMapping;
+ (ADNJSONMapping *)sourceMapping;

@end
