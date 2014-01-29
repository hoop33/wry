//
//  AfterSetting.m
//  wry
//
//  Created by Rob Warner on 1/29/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "AfterSetting.h"

@implementation AfterSetting

- (NSString *)shortFlag {
  return @"t";
}

- (NSString *)summary {
  return @"Return items after the item with the ID <after>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
    @"For commands that return multiple items (e.g., stream), return the items\n"
    @"after the item with the ID <after>."];
  return help;
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
