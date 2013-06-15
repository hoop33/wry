//
//  WrySettings.m
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WrySettings.h"

#define kDefaultUser @"DefaultUser"
#define kEditor @"Editor"

@interface WrySettings ()
+ (id)property:(NSString *)name;
+ (void)setProperty:(NSString *)name value:(id)value;
@end

@implementation WrySettings

+ (NSString *)defaultUser {
  return [WrySettings property:kDefaultUser];
}

+ (void)setDefaultUser:(NSString *)defaultUser {
  [WrySettings setProperty:kDefaultUser value:defaultUser];
}

+ (NSString *)editor {
  return [WrySettings property:kEditor];
}

+ (void)setEditor:(NSString *)editor {
  [WrySettings setProperty:kEditor value:editor];
}

+ (id)property:(NSString *)name {
  return [[NSUserDefaults standardUserDefaults] objectForKey:name];
}

+ (void)setProperty:(NSString *)name value:(id)value {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:name];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
