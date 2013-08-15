//
//  DebugSetting.m
//  wry
//
//  Created by Rob Warner on 7/31/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "DebugSetting.h"

@implementation DebugSetting

- (NSString *)shortFlag {
  return @"d";
}

- (NSString *)summary {
  return @"Show debugging information";
}

- (NSString *)help {
  return @"Show debugging information in the standard output. Useful for troubleshooting.";
}

- (NSUInteger)numberOfParameters {
  return 0;
}

- (NSArray *)allowedValues {
  return @[@NO, @YES];
}

@end
