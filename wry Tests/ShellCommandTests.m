//
//  ShellCommandTests.m
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShellCommand.h"

@interface ShellCommandTests : XCTestCase

@end

@implementation ShellCommandTests {
  ShellCommand *command;
}

- (void)setUp {
  [super setUp];
  command = [[ShellCommand alloc] init];
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

- (void)testPromptShouldNotBeNil {
  XCTAssertNotNil([command performSelector:@selector(prompt)], @"prompt should not be nil");
}

@end
