//
//  UserSetting.m
//  wry
//
//  Created by Rob Warner on 8/2/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UserSetting.h"
#import "SSKeychain.h"
#import "WryApplication.h"

@implementation UserSetting

- (NSString *)shortFlag {
  return @"u";
}

- (NSString *)summary {
  return @"Run as <user>";
}

- (NSString *)help {
  return @"Specifies the App.net user to run as for this command.";
}

- (NSUInteger)numberOfParameters {
  return 1;
}

- (NSArray *)allowedValues {
  NSMutableArray *users = [[NSMutableArray alloc] init];
  for (NSDictionary *account in [SSKeychain accountsForService:[[WryApplication application] appName]]) {
    [users addObject:[account valueForKey:@"acct"]];
  }
  return users;
}

- (WrySettingType)type {
  return WrySettingStringType;
}

@end
