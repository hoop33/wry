//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SettingsDefaultUser;
extern NSString * const SettingsIncludeAnnotations;
extern NSString * const SettingsCount;
extern NSString * const SettingsDebug;
extern NSString * const SettingsFormat;
extern NSString * const SettingsPretty;
extern NSString * const SettingsQuiet;
extern NSString * const SettingsReverse;
extern NSString * const SettingsEditor;
extern NSString * const SettingsSeparator;
extern NSString * const SettingsTextColor;
extern NSString * const SettingsAlertColor;
extern NSString * const SettingsUserColor;
extern NSString * const SettingsNameColor;
extern NSString * const SettingsIDColor;
extern NSString * const SettingsMutedColor;
extern NSString * const SettingsLinkColor;
extern NSString * const SettingsHashtagColor;

@interface WrySettings : NSObject

<<<<<<< HEAD
- (NSString *)stringValue:(NSString *)key;
- (NSInteger)integerValue:(NSString *)key;
- (BOOL)boolValue:(NSString *)key;
- (void)set:(NSString *)key value:(NSObject *)value;
=======
- (NSInteger)getInteger:(NSString *)key;
- (NSString *)getString:(NSString *)key;
- (void)setObject:(NSObject *)value forKey:(NSString *)key;
>>>>>>> Issue #54. Convert all the settings to standalone classes.

@end
