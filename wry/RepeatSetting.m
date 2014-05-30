//
//  RepeatSetting.m
//  wry
//
//  Created by Rob Warner on 5/11/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "RepeatSetting.h"

@implementation RepeatSetting

- (NSString *)shortFlag {
  return @"R";
}

- (NSString *)summary {
  return @"Repeat command every <repeat> seconds";
}

- (NSString *)help {
  return @"Repeats the command every <repeat> seconds.";
}

- (NSUInteger)numberOfParameters {
  return 1;
}

- (NSArray *)allowedValues {
  return nil;
}

- (WrySettingType)type {
  return WrySettingIntegerType;
}

@end
