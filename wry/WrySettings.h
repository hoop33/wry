//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySetting.h"

typedef enum {
  WryColorText = 0,
  WryColorAlert,
  WryColorUser,
  WryColorName,
  WryColorID,
  WryColorMuted,
  WryColorLink,
  WryColorHashtag
} WryColor;

@interface WrySettings : NSObject

- (NSString *)stringValue:(NSString *)key;
- (NSInteger)integerValue:(NSString *)key;
- (BOOL)boolValue:(NSString *)key;
- (NSString *)colorValue:(WryColor)wryColor;
- (void)setTransientValue:(NSString *)value forSetting:(id <WrySetting>)setting;
- (void)setObject:(NSObject *)value forKey:(NSString *)key;

@end
