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

@interface WrySettingsTests : XCTestCase

@end

@implementation WrySettingsTests {
  WrySettings *settings;
}

- (void)setUp
{
  [super setUp];
  settings = [[WrySettings alloc] init];
}

- (void)tearDown
{
  settings = nil;
  [super tearDown];
}

- (void)testSetTransientValueShouldSetValue
{
  [settings setTransientValue:@"TestUser" forSetting:[[UserSetting alloc] init]];
  XCTAssertEqualObjects([settings stringValue:@"user"], @"TestUser", @"The user setting should be 'TestUser'");
}

@end
