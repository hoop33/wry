//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySetting.h"

typedef NS_ENUM(NSInteger, WryColor) {
  WryColorText = 0,
  WryColorAlert,
  WryColorUser,
  WryColorName,
  WryColorID,
  WryColorMuted,
  WryColorLink,
  WryColorHashtag
} ;

@interface WrySettings : NSObject

- (NSString *)stringValue:(NSString *)key;
- (NSInteger)integerValue:(NSString *)key;
- (BOOL)boolValue:(NSString *)key;
- (NSString *)colorValue:(WryColor)wryColor;
- (void)setObject:(NSObject *)value forKey:(NSString *)key;
- (NSDictionary *)mergeWithOptions:(NSDictionary *)options;
- (NSString *)defaultUser;
- (NSString *)accessTokenForUser:(NSString *)user;
- (void)setAccessTokenForUser:(NSString *)user accessToken:(NSString *)accessToken;

@end
