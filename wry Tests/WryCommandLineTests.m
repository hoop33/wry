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
  XCTAssertTrue([cl parseParameters:@[] error:nil]);
}

- (void)testParseNilStringShouldSetCommandToHelp {
  [cl parseString:nil error:nil];
  XCTAssertEqualObjects(cl.commandName, @"help");
}

- (void)testParseCommandLineWithQuotationsShouldTreatQuoteBlockAsOneParameter {
  [cl parseString:@"config editor \"mvim -f\"" error:nil];
  XCTAssertEqualObjects(cl.commandName, @"config");
  XCTAssertEqual(cl.params.count, 2);
  XCTAssertEqualObjects(cl.params[1], @"mvim -f");
}

- (void)testHyphensShouldBeRetainedWithParameters {
  [cl parseString:@"stream -r --count 3 -f text --pretty" error:nil];
  XCTAssertEqualObjects(cl.commandName, @"stream");
  XCTAssertEqual(cl.params.count, 0);
  XCTAssertTrue(cl.overrides[@"reverse"]);
  XCTAssertEqualObjects(cl.overrides[@"count"], @3);
  XCTAssertEqualObjects(cl.overrides[@"format"], @"text");
  XCTAssertTrue(cl.overrides[@"pretty"]);
}

- (void)testAtSignsShouldBeRetained {
  [cl parseString:@"user @hoop33" error:nil];
  XCTAssertEqualObjects(cl.commandName, @"user");
  XCTAssertEqualObjects(cl.params[0], @"@hoop33");
}

- (void)testRunAsUserShouldSetUser {
  [cl parseString:@"-u hoop33_test following" error:nil];
  XCTAssertEqualObjects(cl.commandName, @"following");
  XCTAssertEqualObjects(cl.overrides[@"user"], @"hoop33_test");
}
@end
