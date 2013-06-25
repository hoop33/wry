//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SettingsDefaultUser;
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

- (NSString *)getString:(NSString *)key;
- (void)set:(NSString *)key value:(NSObject *)value;

@end
