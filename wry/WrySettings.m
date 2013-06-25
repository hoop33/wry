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
- (id)property:(NSString *)name;
- (void)setProperty:(NSString *)name value:(id)value;
@end

@implementation WrySettings

- (id)init {
  self = [super init];
  if (self != nil) {
    self.defaultUser = [self property:kDefaultUser];
    self.editor = [self property:kEditor];
  }
  return self;
}

- (void)save {
  [self setProperty:kDefaultUser value:self.defaultUser];
  [self setProperty:kEditor value:self.editor];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)property:(NSString *)name {
  return [[NSUserDefaults standardUserDefaults] objectForKey:name];
}

- (void)setProperty:(NSString *)name value:(id)value {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:name];
}

@end
