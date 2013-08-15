//
//  PrettySetting.m
//  wry
//
//  Created by Rob Warner on 8/2/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "PrettySetting.h"

@implementation PrettySetting

- (NSString *)shortFlag {
  return @"p";
}

- (NSString *)summary {
  return @"Pretty-print the JSON response (for -f json only)";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Applies only when the formatter is set to JSON (-f json).\n"
    @"Pretty-prints the JSON response, with proper indentation, linefeeds, etc."];
  return help;
}

- (NSUInteger)numberOfParameters {
  return 0;
}

- (NSArray *)allowedValues {
  return @[@NO, @YES];
}

@end
