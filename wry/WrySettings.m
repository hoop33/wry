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

@interface WrySettings ()
@property(nonatomic, strong) NSMutableDictionary *overrides;
@property(nonatomic, strong) NSDictionary *legacy;
@end

@implementation WrySettings {
}

- (id)init {
  self = [super init];
  if (self != nil) {
    self.overrides = [[NSMutableDictionary alloc] init];
    self.legacy = @{
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
  // Check for a command-line override
  if ([[self.overrides allKeys] containsObject:key]) {
    value = (NSString *) self.overrides[key];
  } else {
    // Check if they've configured an old key
    if ([[self.legacy allKeys] containsObject:key] && (value = [[NSUserDefaults standardUserDefaults] objectForKey:[self.legacy objectForKey:key]]) != nil) {
      [[NSUserDefaults standardUserDefaults] removeObjectForKey:[self.legacy objectForKey:key]];
      [self setObject:value forKey:key];
    } else {
      // Check the defaults
      value = (NSString *) [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
  }
  return value;
}

- (NSInteger)integerValue:(NSString *)key {
  return [[self.overrides allKeys] containsObject:key] ? [(NSNumber *) self.overrides[key] integerValue] :
    [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

- (BOOL)boolValue:(NSString *)key {
  return [[self.overrides allKeys] containsObject:key] ? [(NSNumber *) self.overrides[key] boolValue] :
    [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

- (NSString *)colorValue:(WryColor)wryColor {
  NSArray *colors = [[self stringValue:[WryUtils nameForSettingForClass:[ColorsSetting class]]] componentsSeparatedByString:@","];
  return colors.count > wryColor ? colors[wryColor] : @"";
}

- (void)setTransientValue:(NSString *)value forSetting:(id <WrySetting>)setting {
  NSObject *object = nil;
  switch ([setting type]) {
    case WrySettingBooleanType:
      object = @YES;
      break;
    case WrySettingIntegerType:
      object = [NSNumber numberWithInteger:[value integerValue]];
      break;
    case WrySettingStringType:
      object = value;
      break;
  }
  [self.overrides setObject:object forKey:[WryUtils nameForSetting:setting]];
}

- (void)setObject:(NSObject *)value forKey:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
