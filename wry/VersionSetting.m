//
//  VersionSetting.m
//  wry
//
//  Created by Rob Warner on 10/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "VersionSetting.h"

@implementation VersionSetting

- (NSString *)shortFlag {
  return @"v";
}

- (NSString *)summary {
  return @"Show version";
}

- (NSString *)help {
  return @"Displays version information.";
}

- (NSUInteger)numberOfParameters {
  return 0;
}

- (NSArray *)allowedValues {
  return @[@NO, @YES];
}

- (WrySettingType)type {
  return WrySettingBooleanType;
}

@end
