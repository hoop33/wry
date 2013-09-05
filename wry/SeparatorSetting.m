//
//  SeparatorSetting.m
//  wry
//
//  Created by Rob Warner on 9/1/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "SeparatorSetting.h"

@implementation SeparatorSetting

- (NSString *)shortFlag {
  return @"s";
}

- (NSString *)summary {
  return @"Set the separator to use between posts et al.";
}

- (NSString *)help {
  return @"Sets the separator to use between items in a list (e.g., posts).";
}

- (NSUInteger)numberOfParameters {
  return 1;
}

- (NSArray *)allowedValues {
  return nil;
}

- (WrySettingType)type {
  return WrySettingStringType;
}

@end
