//
//  WrySettings.m
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySettings.h"
#import "WryUtils.h"
#import "AnnotationsSetting.h"
#import "CountSetting.h"
#import "DebugSetting.h"
#import "FormatSetting.h"
#import "PrettySetting.h"
#import "QuietSetting.h"
#import "ReverseSetting.h"
#import "LongSetting.h"
#import "SeparatorSetting.h"
#import "ColorsSetting.h"
#import "UserSetting.h"
#import "SSKeychain.h"

@interface WrySettings ()
@property (nonatomic, strong) NSDictionary *legacy;
@end

@implementation WrySettings {
}

- (instancetype)init {
  self = [super init];
  if (self != nil) {
    _legacy = @{
      @"user" : @"DefaultUser",
      @"editor" : @"Editor",
      @"separator" : @"Separator"
    };
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
      [WryUtils nameForSettingForClass:[AnnotationsSetting class]] : @NO,
      [WryUtils nameForSettingForClass:[CountSetting class]] : @20,
      [WryUtils nameForSettingForClass:[DebugSetting class]] : @NO,
      [WryUtils nameForSettingForClass:[FormatSetting class]] : @"text",
      [WryUtils nameForSettingForClass:[LongSetting class]] : @"ask",
      [WryUtils nameForSettingForClass:[PrettySetting class]] : @NO,
      [WryUtils nameForSettingForClass:[QuietSetting class]] : @NO,
      [WryUtils nameForSettingForClass:[ReverseSetting class]] : @NO,
      [WryUtils nameForSettingForClass:[SeparatorSetting class]] : @"----------",
      [WryUtils nameForSettingForClass:[ColorsSetting class]] : @"32m,31m,33m,34m,35m,36m,4m,44m"
    }];
  }
  return self;
}

- (NSString *)stringValue:(NSString *)key {
  NSString *value = nil;
  // Check if they've configured an old key
  if ([[self.legacy allKeys] containsObject:key] && (value = [[NSUserDefaults standardUserDefaults] objectForKey:(self.legacy)[key]]) != nil) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:(self.legacy)[key]];
    [self setObject:value forKey:key];
  } else {
    // Check the defaults
    value = (NSString *) [[NSUserDefaults standardUserDefaults] objectForKey:key];
  }
  return value;
}

- (NSInteger)integerValue:(NSString *)key {
  return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

- (BOOL)boolValue:(NSString *)key {
  return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

- (NSString *)colorValue:(WryColor)wryColor {
  NSArray *colors = [[self stringValue:[WryUtils nameForSettingForClass:[ColorsSetting class]]] componentsSeparatedByString:@","];
  return colors.count > wryColor ? colors[wryColor] : @"";
}

- (void)setObject:(NSObject *)value forKey:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)mergeWithOptions:(NSDictionary *)options {
  // In this method, create a dictionary of the settings and then override it with the command line options.
  NSArray *settings = [WryUtils allSettings];
  NSMutableDictionary *merged = [NSMutableDictionary dictionaryWithCapacity:settings.count];

  for (Class settingClass in settings) {
    id <WrySetting> setting = [[settingClass alloc] init];
    NSString *key = [WryUtils nameForSetting:setting];
    NSObject *object = nil;
    switch ([setting type]) {
      case WrySettingUnknownType:
        break;
      case WrySettingBooleanType:
        object = @([self boolValue:key]);
        break;
      case WrySettingIntegerType:
        object = @([self integerValue:key]);
        break;
      case WrySettingStringType:
        object = [self stringValue:key];
        break;
    }
    if (object != nil) {
      merged[key] = object;
    }
  }

  // Now do the options
  for (NSString *key in [options allKeys]) {
    merged[key] = [options valueForKey:key];
  }
  return [NSDictionary dictionaryWithDictionary:merged];
}

- (NSString *)defaultUser {
  return [self stringValue:[WryUtils nameForSettingForClass:[UserSetting class]]];
}

- (NSString *)accessTokenForUser:(NSString *)user {
  return [SSKeychain passwordForService:[WryApplication application].appName
                                account:user];
}

- (void)setAccessTokenForUser:(NSString *)user accessToken:(NSString *)accessToken {
  NSString *appName = [WryApplication application].appName;
  [SSKeychain setPassword:accessToken
               forService:appName
                  account:user];
  if ([SSKeychain accountsForService:appName].count == 1) {
    [self setObject:user forKey:[WryUtils nameForSettingForClass:[UserSetting class]]];
  }
}

@end
