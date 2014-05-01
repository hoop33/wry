//
//  UnescapeBangEnhancerTests.m
//  wry
//
//  Created by Rob Warner on 5/1/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnescapeBangEnhancer.h"

@interface UnescapeBangEnhancerTests : XCTestCase

@end

@implementation UnescapeBangEnhancerTests {
  UnescapeBangEnhancer *enhancer;
}

- (void)setUp {
  [super setUp];
  enhancer = [[UnescapeBangEnhancer alloc] init];
}

- (void)tearDown {
  enhancer = nil;
  [super tearDown];
}

- (void)testNilShouldReturnNil {
  XCTAssertNil([enhancer enhance:nil], @"nil should return nil");
}

- (void)testEmptyShouldReturnEmpty {
  XCTAssertEqualObjects([enhancer enhance:@""], @"", @"empty should return empty");
}

- (void)testAllBangsShouldReturnSame {
  NSString *string = @"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
  XCTAssertEqualObjects([enhancer enhance:string], string, @"all bangs should stay the same");
}

- (void)testEscapedBangsShouldReturnUnescaped {
  XCTAssertEqualObjects([enhancer enhance:@"\\!\\!\\!\\!\\!"], @"!!!!!", @"escaped bangs should be unescaped");
}

- (void)testStringWithEscapedBangsShouldReturnUnescaped {
  XCTAssertEqualObjects([enhancer enhance:@"This is so cool\\! Yes it is\\! Unescaped!"], @"This is so cool! Yes it is! Unescaped!", @"escaped bangs should be unescaped");
}

@end
