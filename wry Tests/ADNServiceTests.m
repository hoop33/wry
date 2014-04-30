//
//  ADNServiceTests.m
//  wry
//
//  Created by Rob Warner on 1/29/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADNService.h"
#import "ADNResponse.h"

@interface ADNServiceTests : XCTestCase

@end

@implementation ADNServiceTests {
  ADNService *service;
  SEL appendParameterSelector;
  IMP appendParameterImplementation;
  SEL pathWithParametersSelector;
  IMP pathWithParametersImplementation;
}

- (void)setUp
{
  [super setUp];
  service = [[ADNService alloc] init];
  appendParameterSelector = NSSelectorFromString(@"appendParameter:toPath:");
  appendParameterImplementation = [service methodForSelector:appendParameterSelector];
  pathWithParametersSelector = NSSelectorFromString(@"pathWithParameters:includeCount:");
  pathWithParametersImplementation = [service methodForSelector:pathWithParametersSelector];
}

- (void)tearDown
{
  service = nil;
  appendParameterSelector = nil;
  appendParameterImplementation = nil;
  pathWithParametersSelector = nil;
  pathWithParametersImplementation = nil;
  [super tearDown];
}

#pragma mark - addToPath

- (void)testAddToPathShouldReturnNilForNilPath {
  XCTAssertNil(appendParameterImplementation(service, appendParameterSelector, @"foo=bar", nil), @"the path should be nil for a nil path");
}

- (void)testAddToPathShouldReturnPathForEmptyPath {
  XCTAssertEqualObjects(appendParameterImplementation(service, appendParameterSelector, @"foo=bar", @""), @"", @"the path should be unchanged for an empty path");
}

- (void)testAddToPathShouldReturnPathForNilParameter {
  XCTAssertEqualObjects(appendParameterImplementation(service, appendParameterSelector, nil, @"http://example.com"), @"http://example.com", @"the path should be unchanged for a nil parameter");
}

- (void)testAddToPathShouldReturnPathForEmptyParameter {
  XCTAssertEqualObjects(appendParameterImplementation(service, appendParameterSelector, @"", @"http://example.com"), @"http://example.com", @"the path should be unchanged for an empty parameter");
}

- (void)testAddToPathShouldAppendQuestionMarkBeforeParameter {
  XCTAssertEqualObjects(appendParameterImplementation(service, appendParameterSelector, @"foo=bar", @"http://example.com"), @"http://example.com?foo=bar", @"the parameter should have been appended with a question mark");
}

- (void)testAddToPathShouldAppendAmpersandBeforeParameterWhenPathHasQuestionMark {
  XCTAssertEqualObjects(appendParameterImplementation(service, appendParameterSelector, @"foo=bar", @"http://example.com?baz=SuperBowl"), @"http://example.com?baz=SuperBowl&foo=bar", @"the parameter should have been appended with an ampersand");
}

#pragma mark - pathWithParameters

- (void)testPathWithParametersShouldNotIncludeCountWhenNO {
  XCTAssertEqualObjects(pathWithParametersImplementation(service, pathWithParametersSelector, @"http://example.com", NO), @"http://example.com", @"Should not have appended any parameters");
}

- (void)testPathWithParametersShouldIncludeCountWhenYES {
  XCTAssertEqualObjects(pathWithParametersImplementation(service, pathWithParametersSelector, @"http://example.com", YES), @"http://example.com?count=0", @"Should have appended count");
}

- (void)testPathWithParametersShouldIncludeAnnotations {
  service.annotations = YES;
  XCTAssertEqualObjects(pathWithParametersImplementation(service, pathWithParametersSelector, @"http://example.com", NO), @"http://example.com?include_annotations=1", @"Should have appended annotations");
}

- (void)testPathWithParametersShouldIncludeBeforeId {
  service.beforeId = @"12345";
  XCTAssertEqualObjects(pathWithParametersImplementation(service, pathWithParametersSelector, @"http://example.com", NO), @"http://example.com?before_id=12345", @"Should have appended before_id");
}

- (void)testPathWithParametersShouldIncludeSinceId {
  service.sinceId = @"54321";
  XCTAssertEqualObjects(pathWithParametersImplementation(service, pathWithParametersSelector, @"http://example.com", NO), @"http://example.com?since_id=54321", @"Should have appended since_id");
}

- (void)testPathWithParametersShouldIncludeParameters {
  service.count = 50;
  service.annotations = YES;
  service.beforeId = @"12345";
  service.sinceId = @"54321";
  XCTAssertEqualObjects(pathWithParametersImplementation(service, pathWithParametersSelector, @"http://example.com", YES), @"http://example.com?count=50&include_annotations=1&before_id=12345&since_id=54321", @"Should have appended parameters");
}

#pragma mark - Posts

- (void)testCreatePostWithNilTextShouldReturnNil {
  XCTAssertNil([service createPost:nil replyID:nil error:nil]);
}

- (void)testCreatePostWithEmptyTextShouldReturnNil {
  XCTAssertNil([service createPost:@"" replyID:nil error:nil]);
}

- (void)testCreatePostWithNilTextAndErrorShouldFillOutError {
  NSError *error;
  XCTAssertNil([service createPost:nil replyID:nil error:&error]);
  XCTAssertNotNil(error);
  XCTAssertEqualObjects(error.userInfo[NSLocalizedDescriptionKey], @"You must supply text");
}

- (void)testCreatePostWithEmptyTextAndErrorShouldFillOutError {
  NSError *error;
  XCTAssertNil([service createPost:@"" replyID:nil error:&error]);
  XCTAssertNotNil(error);
  XCTAssertEqualObjects(error.userInfo[NSLocalizedDescriptionKey], @"You must supply text");
}

#pragma mark - Messages

- (void)testSendMessageWithNilTextShouldReturnNil {
  XCTAssertNil([service sendMessage:nil replyID:nil channelID:nil text:nil error:nil]);
}

- (void)testSendMessageWithEmptyTextShouldReturnNil {
  XCTAssertNil([service sendMessage:nil replyID:nil channelID:nil text:@"" error:nil]);
}

- (void)testSendMessageWithNilTextAndErrorShouldFillOutError {
  NSError *error;
  XCTAssertNil([service sendMessage:nil replyID:nil channelID:nil text:nil error:&error]);
  XCTAssertNotNil(error);
  XCTAssertEqualObjects(error.userInfo[NSLocalizedDescriptionKey], @"You must supply text");
}

- (void)testSendMessageWithEmptyTextAndErrorShouldFillOutError {
  NSError *error;
  XCTAssertNil([service sendMessage:nil replyID:nil channelID:nil text:@"" error:&error]);
  XCTAssertNotNil(error);
  XCTAssertEqualObjects(error.userInfo[NSLocalizedDescriptionKey], @"You must supply text");
}

@end
