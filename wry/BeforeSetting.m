//
//  BeforeSetting.m
//  wry
//
//  Created by Rob Warner on 1/28/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "BeforeSetting.h"

@implementation BeforeSetting

- (NSString *)shortFlag {
  return @"b";
}

- (NSString *)summary {
  return @"Return items before the item with the ID <before>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
    @"For commands that return multiple items (e.g., stream), return the items\n"
    @"before the item with the ID <before>."];
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
