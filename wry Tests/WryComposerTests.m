//
//  WryComposerTests.m
//  wry
//
//  Created by Rob Warner on 1/16/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WryComposer.h"

@interface WryComposerTests : XCTestCase

@end

@implementation WryComposerTests {
  WryComposer *composer;
}

- (void)setUp
{
  [super setUp];
  composer = [[WryComposer alloc] init];
}

- (void)tearDown
{
  composer = nil;
  [super tearDown];
}

- (void)testHelpShouldNotBeNil {
  XCTAssertNotNil([WryComposer help], @"help should not be nil");
}

- (void)testShellShouldNotBeNil {
  XCTAssertNotNil([composer performSelector:@selector(shell)], @"shell should not be nil");
}

- (void)testEditorShouldNotBeNil {
  XCTAssertNotNil([composer performSelector:@selector(editor)], @"editor should not be nil");
}

- (void)testTempFileNameShouldNotBeNil {
  NSString *tempFileName = [composer performSelector:@selector(tempFileName)];
  XCTAssertNotNil(tempFileName, @"tempFileName should not be nil");
  [[NSFileManager defaultManager] removeItemAtPath:tempFileName error:nil];
}

- (void)testTempFileNameShouldExistAsFile {
  NSString *tempFileName = [composer performSelector:@selector(tempFileName)];
  XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:tempFileName isDirectory:NO], @"tempFileName should represent an existing file");
  [[NSFileManager defaultManager] removeItemAtPath:tempFileName error:nil];
}

- (void)testFilterCommentsShouldReturnNilForNilText {
  XCTAssertNil([composer performSelector:@selector(filterComments:) withObject:nil], @"filterComments should return nil for nil text");
}

- (void)testFilterCommentsShouldReturnEmptyStringForEmptyText {
  XCTAssertEqualObjects([composer performSelector:@selector(filterComments:) withObject:@""], @"", @"filterComments should return empty string for empty text");
}

- (void)testFilterCommentsShouldReturnOriginalTextForTextWithNoComments {
  NSString *text = @"This is test text with no comments\nI don't want to see any comments\nOK?";
  XCTAssertEqualObjects([composer performSelector:@selector(filterComments:) withObject:text], text, @"filterComments should not change uncommented text");
}

- (void)testFilterCommentsShouldReturnEmptyStringForAllComments {
  NSString *text = @"#This is test text with comments\n#I don't want to see any comments\n#OK?";
  XCTAssertEqualObjects([composer performSelector:@selector(filterComments:) withObject:text], @"", @"filterComments should remove comments from text");
}

- (void)testFilterCommentsShouldReturnNonCommentLinesOnly {
  NSString *text = @"#This is test text with comments\nI don't want to see any comments\n#OK?";
  XCTAssertEqualObjects([composer performSelector:@selector(filterComments:) withObject:text], @"I don't want to see any comments\n", @"filterComments should remove comments from text");
}

- (void)testFilterCommentsShouldReturnNonCommentLinesOnlyWithMoreLines {
  NSString *text = @"#This is test text with comments\nI don't want to see any comments\n#OK?\nThat's right";
  XCTAssertEqualObjects([composer performSelector:@selector(filterComments:) withObject:text], @"I don't want to see any comments\nThat's right", @"filterComments should remove comments from text");
}

@end
