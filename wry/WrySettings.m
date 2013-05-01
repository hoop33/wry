//
//  WrySettings.m
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySettings.h"

#define kDefaultUser @"DefaultUser"

@implementation WrySettings

+ (NSString *)defaultUser {
  return [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultUser];
}

+ (void)setDefaultUser:(NSString *)defaultUser {
  [[NSUserDefaults standardUserDefaults] setObject:defaultUser forKey:kDefaultUser];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
