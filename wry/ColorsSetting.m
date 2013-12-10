//
//  ColorsSetting.m
//  wry
//
//  Created by Rob Warner on 9/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ColorsSetting.h"

@implementation ColorsSetting

- (NSString *)shortFlag {
  return @"o";
}

- (NSString *)summary {
  return @"Set output colors";
}

- (NSString *)help {
  typedef enum {
    WryColorText = 0,
    WryColorAlert,
    WryColorUser,
    WryColorName,
    WryColorID,
    WryColorMuted,
    WryColorLink,
    WryColorHashtag
  } WryColor;
  return @"Set the colors to use for output. These colors are expressed as ANSI color\n"
    @"codes, separated by commas. You should have 8 colors in this order:\n"
    @"\n"
    @"   * Text\n"
    @"   * Alert\n"
    @"   * User\n"
    @"   * Name\n"
    @"   * ID\n"
    @"   * Muted\n"
    @"   * Link\n"
    @"   * Hashtag\n"
    @"\n"
    @"Example: 32m,31m,33m,34m,35m,36m,34m,44m\n";
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
