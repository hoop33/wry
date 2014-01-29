//
//  BeforeSettingTests.m
//  wry
//
//  Created by Rob Warner on 1/28/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BeforeSetting.h"

@interface BeforeSettingTests : XCTestCase

@end

@implementation BeforeSettingTests {
  BeforeSetting *setting;
}

- (void)setUp
{
  [super setUp];
  setting = [[BeforeSetting alloc] init];
}

- (void)tearDown
{
  setting = nil;
  [super tearDown];
}

- (void)testShortFlagShouldBeB {
  XCTAssertEqualObjects([setting shortFlag], @"b", @"the short flag should be 'b'");
}

- (void)testSummaryShouldNotBeNil {
  XCTAssertNotNil([setting summary], @"the summary should not be nil");
}

- (void)testHelpShouldNotBeNil {
  XCTAssertNotNil([setting help], @"the help should not be nil");
}

- (void)testNumberOfParametersShouldBeOne {
  XCTAssertEqual([setting numberOfParameters], 1ul, @"the number of parameters should be 1");
}

- (void)testAllowedValuesShouldBeNil {
  XCTAssertNil([setting allowedValues], @"the allowed values should be nil");
}

- (void)testTypeShouldBeString {
  XCTAssertEqual([setting type], WrySettingStringType, @"the type should be 'string'");
}

@end
