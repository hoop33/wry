//
//  EditorSetting.m
//  wry
//
//  Created by Rob Warner on 9/1/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "EditorSetting.h"

@implementation EditorSetting

- (NSString *)shortFlag {
  return @"e";
}

- (NSString *)summary {
  return @"Set the editor to use for composing text.";
}

- (NSString *)help {
  return @"Sets the editor to use for composing text for posts, replies, or messages.";
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
