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

@end
