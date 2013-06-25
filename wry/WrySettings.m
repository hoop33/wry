//
//  WrySettings.m
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySettings.h"

NSString * const SettingsDefaultUser = @"DefaultUser";
NSString * const SettingsEditor = @"Editor";
NSString * const SettingsTextColor = @"TextColor";
NSString * const SettingsAlertColor = @"AlertColor";
NSString * const SettingsUserColor = @"UserColor";
NSString * const SettingsNameColor = @"NameColor";
NSString * const SettingsIDColor = @"IDColor";
NSString * const SettingsMutedColor = @"MutedColor";
NSString * const SettingsLinkColor = @"LinkColor";
NSString * const SettingsHashtagColor = @"HashtagColor";

@implementation WrySettings

- (id)init {
  self = [super init];
  if (self != nil) {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
      SettingsTextColor : @"32m",
      SettingsAlertColor : @"31m",
      SettingsUserColor : @"33m",
      SettingsNameColor : @"34m",
      SettingsIDColor : @"35m",
      SettingsMutedColor : @"36m",
      SettingsLinkColor : @"34m\x1b[4m",
      SettingsHashtagColor : @"44m"
    }];
  }
  return self;
}

- (NSString *)getString:(NSString *)key {
  return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)set:(NSString *)key value:(NSObject *)value {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
