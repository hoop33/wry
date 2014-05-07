//
//  RmCommandTests.m
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RmCommand.h"

@interface RmCommandTests : XCTestCase

@end

@implementation RmCommandTests {
  RmCommand *command;
}

- (void)setUp {
  [super setUp];
  command = [[RmCommand alloc] init];
}

- (void)tearDown {
  command = nil;
  [super tearDown];
}

- (void)testHelpShouldNotBeNil {
  XCTAssertNotNil([command help], @"help should not be nil");
}

- (void)testUsageShouldNotBeNil {
  XCTAssertNotNil([command usage], @"usage should not be nil");
}

- (void)testSummaryShouldNotBeNil {
  XCTAssertNotNil([command summary], @"summary should not be nil");
}

- (void)testNoParametersShouldFail {
  XCTAssertFalse([command run:@[] formatter:nil options:nil error:nil], @"message with no params should fail");
}

@end
