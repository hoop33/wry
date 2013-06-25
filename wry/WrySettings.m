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

@implementation WrySettings

- (id)init {
  self = [super init];
  if (self != nil) {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
      SettingsTextColor : @"31m"
    }];
  }
  return self;
}

- (NSObject *)getString:(NSString *)key {
  return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)set:(NSString *)key value:(NSObject *)value {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
