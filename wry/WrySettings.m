//
//  WrySettings.m
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySettings.h"

// TODO This class should contain a dictionary of WrySetting names and the actual values
NSString * const SettingsDefaultUser = @"DefaultUser";
NSString * const SettingsIncludeAnnotations = @"IncludeAnnotations";
NSString * const SettingsCount = @"Count";
NSString * const SettingsDebug = @"Debug";
NSString * const SettingsFormat = @"Format";
NSString * const SettingsPretty = @"Pretty";
NSString * const SettingsQuiet = @"Quiet";
NSString * const SettingsReverse = @"Reverse";
NSString * const SettingsEditor = @"Editor";
NSString * const SettingsSeparator = @"Separator";
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
      SettingsIncludeAnnotations : @NO,
      SettingsCount : @20,
      SettingsDebug : @NO,
      SettingsFormat : @"text",
      SettingsPretty : @NO,
      SettingsQuiet : @NO,
      SettingsReverse : @NO,
      SettingsSeparator : @"----------",
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

- (NSString *)stringValue:(NSString *)key {
  return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (NSInteger)integerValue:(NSString *)key {
  return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

- (BOOL)boolValue:(NSString *)key {
  return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

- (void)setObject:(NSObject *)value forKey:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
