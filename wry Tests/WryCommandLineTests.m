//
//  WryCommandLineTests.m
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WryCommandLine.h"
#import "WryUtils.h"

@interface WryCommandLineTests : XCTestCase

@end

@implementation WryCommandLineTests {
  WryCommandLine *cl;
}

- (void)setUp {
  [super setUp];
  cl = [[WryCommandLine alloc] init];
}

- (void)tearDown {
  cl = nil;
  [super tearDown];
}

- (void)testParseNilStringShouldReturnTrue {
  XCTAssertTrue([cl parseString:nil error:nil]);
}

- (void)testParseEmptyStringShouldReturnTrue {
  XCTAssertTrue([cl parseString:@"" error:nil]);
}

- (void)testParseNilArrayShouldReturnTrue {
  XCTAssertTrue([cl parseParameters:nil error:nil]);
}

- (void)testParseEmptyArrayShouldReturnTrue {
  XCTAssertTrue([cl parseParameters:[NSArray array] error:nil]);
}

- (void)testParseNilStringShouldSetCommandToHelp {
  [cl parseString:nil error:nil];
  XCTAssertEqualObjects(cl.commandName, @"help");
}

@end
