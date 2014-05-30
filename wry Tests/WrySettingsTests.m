//
//  WrySettingsTests.m
//  wry
//
//  Created by Rob Warner on 1/15/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WrySettings.h"
#import "UserSetting.h"
#import "CountSetting.h"
#import "DebugSetting.h"
#import "ColorsSetting.h"
#import "WryUtils.h"

@interface WrySettingsTests : XCTestCase

@end

@implementation WrySettingsTests {
  WrySettings *settings;
}

- (void)setUp {
  [super setUp];
  settings = [[WrySettings alloc] init];
}

- (void)tearDown {
  settings = nil;
  [super tearDown];
}

- (void)testDefaultFormatShouldBeText {
  XCTAssertEqualObjects([settings stringValue:@"format"], @"text", @"The default format should be text");
}

- (void)testMergeWithOptionsShouldOverrideSettings {
  NSDictionary *merged = [settings mergeWithOptions:@{
    [WryUtils nameForSettingForClass:[CountSetting class]] : @7,
    [WryUtils nameForSettingForClass:[UserSetting class]] : @"TestUser",
    [WryUtils nameForSettingForClass:[DebugSetting class]] : @YES
  }];

  XCTAssertEqualObjects([merged valueForKey:[WryUtils nameForSettingForClass:[CountSetting class]]], @7);
  XCTAssertEqualObjects([merged valueForKey:[WryUtils nameForSettingForClass:[UserSetting class]]], @"TestUser");
  XCTAssertTrue([WryUtils nameForSettingForClass:[DebugSetting class]]);
}

@end
