//
//  CountSetting.m
//  wry
//
//  Created by Rob Warner on 8/2/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "CountSetting.h"
#import "WryRange.h"

@implementation CountSetting

- (NSString *)shortFlag {
  return @"c";
}

- (NSString *)summary {
  return @"Limit count to <count> items";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
    @"For commands that return multiple items (e.g., stream), you can limit the number\n"
      @"of items returned to <count> items, where count is a number between 1 and 200."];
  return help;
}

- (NSUInteger)numberOfParameters {
  return 1;
}

- (NSArray *)allowedValues {
  return @[[[WryRange alloc] initWithFrom:1 to:200]];
}

- (WrySettingType)type {
  return WrySettingIntegerType;
}

@end
