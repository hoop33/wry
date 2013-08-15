//
//  ReverseSetting.m
//  wry
//
//  Created by Rob Warner on 8/2/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ReverseSetting.h"

@implementation ReverseSetting

- (NSString *)shortFlag {
  return @"r";
}

- (NSString *)summary {
  return @"Reverse the order of the output";
}

- (NSString *)help {
  return @"Reverses the order of any output that App.net sends.";
}

- (NSUInteger)numberOfParameters {
  return 0;
}

- (NSArray *)allowedValues {
  return @[@NO, @YES];
}

@end
