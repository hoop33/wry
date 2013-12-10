//
//  QuietSetting.m
//  wry
//
//  Created by Rob Warner on 8/2/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "QuietSetting.h"

@implementation QuietSetting

- (NSString *)shortFlag {
  return @"q";
}

- (NSString *)summary {
  return @"Mute all output";
}

- (NSString *)help {
  return @"Mute all output from any commands run.";
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
