//
//  ADNMappingProvider.h
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@class RWJSONMapping;

@interface ADNMappingProvider : NSObject

+ (RWJSONMapping *)userMapping;
+ (RWJSONMapping *)userDescriptionMapping;
+ (RWJSONMapping *)postMapping;
+ (RWJSONMapping *)fileMapping;
+ (RWJSONMapping *)messageMapping;
+ (RWJSONMapping *)channelMapping;

@end
