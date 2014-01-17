//
//  WryApplicationTests.m
//  wry
//
//  Created by Rob Warner on 1/17/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WryApplication.h"

@interface WryApplicationTests : XCTestCase

@end

@implementation WryApplicationTests

- (void)setUp
{
  [super setUp];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testSingletonApplicationShouldNotBeNil {
  XCTAssertNotNil([WryApplication application], @"The singleton application should not be nil");
}

- (void)testSingletonApplicationShouldBeSame {
  WryApplication *application = [WryApplication application];
  XCTAssertEqual([WryApplication application], application, @"The singleton application should always be the same one");
}

- (void)testMaximumPostLengthShouldBe256 {
  XCTAssertEqual([WryApplication maximumPostLength], 256, @"The maximum post length should be 256");
}

@end
