//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySetting.h"

extern NSString * const SettingsTextColor;
extern NSString * const SettingsAlertColor;
extern NSString * const SettingsUserColor;
extern NSString * const SettingsNameColor;
extern NSString * const SettingsIDColor;
extern NSString * const SettingsMutedColor;
extern NSString * const SettingsLinkColor;
extern NSString * const SettingsHashtagColor;

@interface WrySettings : NSObject

- (NSString *)stringValue:(NSString *)key;
- (NSInteger)integerValue:(NSString *)key;
- (BOOL)boolValue:(NSString *)key;
- (void)setTransientValue:(NSString *)value forSetting:(id <WrySetting>)setting;
- (void)setObject:(NSObject *)value forKey:(NSString *)key;

@end
