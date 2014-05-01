//
//  WryComposerTests.m
//  wry
//
//  Created by Rob Warner on 1/16/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WryComposer.h"
#import "ADNResponse.h"
#import "ADNMappingProvider.h"

@interface WryComposerTests : XCTestCase

@end

@implementation WryComposerTests {
  WryComposer *composer;
}

- (void)setUp {
  [super setUp];
  composer = [[WryComposer alloc] init];
}

- (void)tearDown {
  composer = nil;
  [super tearDown];
}

- (void)testHelpShouldNotBeNil {
  XCTAssertNotNil([WryComposer help], @"help should not be nil");
}

- (void)testShellShouldNotBeNil {
  XCTAssertNotNil([composer performSelector:@
    selector(shell)], @"shell should not be nil");
}

- (void)testEditorShouldNotBeNil {
  XCTAssertNotNil([composer performSelector:@
    selector(editor)], @"editor should not be nil");
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
  XCTAssertNil([composer performSelector:@
    selector(filterComments:) withObject:nil], @"filterComments should return nil for nil text");
}

- (void)testFilterCommentsShouldReturnEmptyStringForEmptyText {
  XCTAssertEqualObjects([composer performSelector:@
    selector(filterComments:) withObject:@""], @"", @"filterComments should return empty string for empty text");
}

- (void)testFilterCommentsShouldReturnOriginalTextForTextWithNoComments {
  NSString *text = @"This is test text with no comments\nI don't want to see any comments\nOK?";
  XCTAssertEqualObjects([composer performSelector:@
    selector(filterComments:) withObject:text], text, @"filterComments should not change uncommented text");
}

- (void)testFilterCommentsShouldReturnEmptyStringForAllComments {
  NSString *text = @"#This is test text with comments\n#I don't want to see any comments\n#OK?";
  XCTAssertEqualObjects([composer performSelector:@
    selector(filterComments:) withObject:text], @"", @"filterComments should remove comments from text");
}

- (void)testFilterCommentsShouldReturnNonCommentLinesOnly {
  NSString *text = @"#This is test text with comments\nI don't want to see any comments\n#OK?";
  XCTAssertEqualObjects([composer performSelector:@
    selector(filterComments:) withObject:text], @"I don't want to see any comments\n", @"filterComments should remove comments from text");
}

- (void)testFilterCommentsShouldReturnNonCommentLinesOnlyWithMoreLines {
  NSString *text = @"#This is test text with comments\nI don't want to see any comments\n#OK?\nThat's right";
  XCTAssertEqualObjects([composer performSelector:@
    selector(filterComments:) withObject:text], @"I don't want to see any comments\nThat's right", @"filterComments should remove comments from text");
}

- (void)testCommentShouldNotBeNil {
  XCTAssertNotNil([composer performSelector:@
    selector(comment)], @"comment should not be nil");
}

- (void)testCommentShouldStartWithPound {
  XCTAssertTrue([[composer performSelector:@ selector(comment)] hasPrefix:@"#"], @"comment should start with a #");
}

- (void)testReplyToUsernameShouldBeEmptyForNilPost {
  XCTAssertEqualObjects([composer performSelector:@
    selector(replyToUsername)], @"", @"replyToUsername should be empty for nil post");
}

- (void)testReplyToUsernameShouldBeUsernameFromPost {
  NSData *data = [NSData dataWithContentsOfFile:[self resourcePath:@"post.json"]];
  ADNResponse *response = [[ADNResponse alloc] initWithData:data mapping:[ADNMappingProvider postMapping] reverse:NO error:nil];
  composer.post = response.object;
  XCTAssertEqualObjects([composer performSelector:@
    selector(replyToUsername)], @"@hoop33", @"replyToUsername should be @hoop33");
}

- (void)testReplyToTextShouldBeEmptyForNilPost {
  XCTAssertEqualObjects([composer performSelector:@
    selector(replyToText)], @"", @"replyToText should be empty for nil post");
}

- (void)testReplyToTextShouldBeTextFromPost {
  NSData *data = [NSData dataWithContentsOfFile:[self resourcePath:@"post.json"]];
  ADNResponse *response = [[ADNResponse alloc] initWithData:data mapping:[ADNMappingProvider postMapping] reverse:NO error:nil];
  composer.post = response.object;
  XCTAssertEqualObjects([composer performSelector:@
    selector(replyToText)],
      @"# -------------------------\n"
        "# Replying to post:\n"
        "# Wait—what? A professional sports league that harbors racism? How could we have seen that coming? #redskins #indians", @"replyToText should be text from post");
}

- (NSString *)resourcePath:(NSString *)filename {
  return [NSString stringWithFormat:@"%@/%@", [[NSBundle bundleForClass:[self class]] resourcePath], filename];
}

@end
