//
//  FormatSetting.m
//  wry
//
//  Created by Rob Warner on 8/2/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FormatSetting.h"
#import "WryUtils.h"
#import "WryApplication.h"

@implementation FormatSetting

- (NSString *)shortFlag {
  return @"f";
}

- (NSString *)summary {
  return @"Display output in <format>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendFormat:@"%@ supports various formats for output. These formats are:\n\n", [[WryApplication application] appName]];
  for (Class cls in [WryUtils allFormatters]) {
    id <WryFormatter> formatter = [[cls alloc] init];
    [help appendFormat:@"* %-6s   %@\n", [[WryUtils nameForFormatter:formatter] UTF8String], [formatter summary]];
  }
  return help;
}

- (NSUInteger)numberOfParameters {
  return 1;
}

- (NSArray *)allowedValues {
  NSArray *formatters = [WryUtils allFormatters];
  NSMutableArray *values = [NSMutableArray arrayWithCapacity:formatters.count];
  for (Class cls in formatters) {
    id <WryFormatter> formatter = [[cls alloc] init];
    [values addObject:[WryUtils nameForFormatter:formatter]];
  }
  return values;
}

@end
