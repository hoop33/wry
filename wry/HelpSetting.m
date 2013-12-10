//
//  HelpSetting.m
//  wry
//
//  Created by Rob Warner on 10/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "HelpSetting.h"

@implementation HelpSetting

- (NSString *)shortFlag {
  return @"h";
}

- (NSString *)summary {
  return @"Show help";
}

- (NSString *)help {
  return @"Displays help.";
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
