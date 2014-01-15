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

- (void)testSetTransientValueShouldSetStringValue {
  [settings setTransientValue:@"TestUser" forSetting:[[UserSetting alloc] init]];
  XCTAssertEqualObjects([settings stringValue:@"user"], @"TestUser", @"The user setting should be 'TestUser'");
}

- (void)testSetTransientValueShouldIntegerValue {
  [settings setTransientValue:@"7" forSetting:[[CountSetting alloc] init]];
  XCTAssertEqualObjects([NSNumber numberWithInteger:[settings integerValue:@"count"]], @7, @"The count setting should be 7");
}

- (void)testSetTransientValueShouldSetBoolValue {
  [settings setTransientValue:@"whatever" forSetting:[[DebugSetting alloc] init]];
  XCTAssertTrue([settings boolValue:@"debug"], @"The debug setting should be true");
}

- (void)testDefaultFormatShouldBeText {
  XCTAssertEqualObjects([settings stringValue:@"format"], @"text", @"The default format should be text");
}

@end
