//
//  AnnotationsSetting.m
//  wry
//
//  Created by Rob Warner on 8/2/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "AnnotationsSetting.h"

@implementation AnnotationsSetting

- (NSString *)shortFlag {
  return @"a";
}

- (NSString *)summary {
  return @"Include annotations";
}

- (NSString *)help {
  return @"Include any annotations for the requested data in the output.";
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
