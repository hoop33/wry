//
//  TextTooLongEnhancerTests.m
//  wry
//
//  Created by Rob Warner on 1/25/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TextTooLongEnhancer.h"

@interface MockTextTooLongEnhancer : TextTooLongEnhancer

@property (nonatomic, copy) NSString *option;

@end

@implementation MockTextTooLongEnhancer

- (NSString *)textTooLongOption {
  return self.option;
}

@end

@interface TextTooLongEnhancerTests : XCTestCase

@end

@implementation TextTooLongEnhancerTests {
  MockTextTooLongEnhancer *enhancer;
  NSString *longText;
  NSString *shortText;
}

- (void)setUp
{
  [super setUp];
  enhancer = [[MockTextTooLongEnhancer alloc] init];
  longText = @"test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test";
  shortText = @"test";
}

- (void)tearDown
{
  enhancer = nil;
  longText = nil;
  shortText = nil;
  [super tearDown];
}

- (void)testRejectShouldReturnNil {
  XCTAssertNil([enhancer performSelector:@selector(reject:) withObject:longText], @"reject should return nil");
}

- (void)testTruncateShouldReturn256Characters {
  XCTAssertEqual([(NSString *)[enhancer performSelector:@selector(truncate:) withObject:longText] length], 256ul, @"truncate should truncate to 256 characters");
}

- (void)testSplitShouldReturn3Strings {
  XCTAssertEqual([(NSArray *)[enhancer performSelector:@selector(split:) withObject:longText] count], 3ul, @"split should split into 3 strings");
}

- (void)testRejectWithNilShouldReturnNil {
  XCTAssertNil([enhancer performSelector:@selector(reject:) withObject:nil], @"reject should return nil");
}

- (void)testTruncateWithNilShouldReturnNil {
  XCTAssertNil([enhancer performSelector:@selector(truncate:) withObject:nil], @"truncate should return nil");
}

- (void)testSplitWithNilShouldReturnNil {
  XCTAssertNil([enhancer performSelector:@selector(split:) withObject:nil], @"split should return nil");
}

- (void)testRejectWithShortTextShouldReturnShortText {
  XCTAssertEqualObjects([enhancer performSelector:@selector(reject:) withObject:shortText], shortText, @"reject should return the same string");
}

- (void)testTruncateWithShortTextShouldReturnShortText {
  XCTAssertEqualObjects([enhancer performSelector:@selector(truncate:) withObject:shortText], shortText, @"truncate should return the same string");
}

- (void)testSplitWithShortTextShouldReturnArrayWithShortText {
  XCTAssertEqualObjects(((NSArray *)[enhancer performSelector:@selector(split:) withObject:shortText])[0], shortText, @"split should return an array with the same string");
}

- (void)testEnhanceRejectWithNilShouldReturnNil {
  enhancer.option = @"reject";
  XCTAssertNil([enhancer enhance:nil], @"reject should return nil");
}

- (void)testEnhanceTruncateWithNilShouldReturnNil {
  enhancer.option = @"truncate";
  XCTAssertNil([enhancer enhance:nil], @"truncate should return nil");
}

- (void)testEnhanceSplitWithNilShouldReturnNil {
  enhancer.option = @"split";
  XCTAssertNil([enhancer enhance:nil], @"split should return nil");
}

- (void)testEnhanceRejectWithLongTextShouldReturnNil {
  enhancer.option = @"reject";
  XCTAssertNil([enhancer enhance:longText], @"reject should return nil");
}

- (void)testEnhanceTruncateWithLongTextShouldReturn256Characters {
  enhancer.option = @"truncate";
  XCTAssertEqual([[enhancer enhance:longText] length], 256ul, @"truncate should return 256 characters");
}

- (void)testEnhanceSplitWithLongTextShouldReturn3Strings {
  enhancer.option = @"split";
  XCTAssertEqual([(NSArray *)[enhancer enhance:longText] count], 3ul, @"split should split into 3 strings");
}

- (void)testEnhanceRejectWithShortTextShouldReturnShortText {
  enhancer.option = @"reject";
  XCTAssertEqualObjects([enhancer enhance:shortText], shortText, @"reject should return the same string");
}

- (void)testEnhanceTruncateWithShortTextShouldReturnShortText {
  enhancer.option = @"truncate";
  XCTAssertEqualObjects([enhancer enhance:shortText], shortText, @"truncate should return the same string");
}

- (void)testEnhanceSplitWithShortTextShouldReturnArrayWithShortText {
  enhancer.option = @"split";
  XCTAssertEqualObjects([enhancer enhance:shortText], shortText, @"split should return the same string");
}

@end
