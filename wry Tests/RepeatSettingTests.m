//
//  RepeatSettingTests.m
//  wry
//
//  Created by Rob Warner on 5/11/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RepeatSetting.h"

@interface RepeatSettingTests : XCTestCase

@end

@implementation RepeatSettingTests {
  RepeatSetting *setting;
}

- (void)setUp
{
  [super setUp];
  setting = [[RepeatSetting alloc] init];
}

- (void)tearDown
{
  setting = nil;
  [super tearDown];
}

- (void)testShortFlagShouldBeR {
  XCTAssertEqualObjects([setting shortFlag], @"R");
}

- (void)testSummaryShouldNotBeNil {
  XCTAssertNotNil([setting summary]);
}

- (void)testHelpShouldNotBeNil {
  XCTAssertNotNil([setting help]);
}

- (void)testNumberOfParametersShouldBeOne {
  XCTAssertEqual([setting numberOfParameters], 1ul);
}

- (void)testAllowedValuesShouldBeNil {
  XCTAssertNil([setting allowedValues]);
}

- (void)testTypeShouldBeInteger {
  XCTAssertEqual([setting type], WrySettingIntegerType);
}

@end
