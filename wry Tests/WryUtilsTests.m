//
//  WryUtilsTests.m
//  wry
//
//  Created by Rob Warner on 5/8/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WryUtils.h"

@interface WryUtilsTests : XCTestCase

@end

@implementation WryUtilsTests {
  NSString *path;
}

- (void)setUp {
  [super setUp];
  [WryApplication application].appName = @"wry";
  path = [NSString stringWithFormat:@"%@/.wry/test", NSHomeDirectory()];
}

- (void)tearDown {
  [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
  [super tearDown];
}

- (void)testInfoPathForNilShouldBeNil {
  XCTAssertNil([WryUtils infoPath:nil error:nil]);
}

- (void)testInfoPathForEmptyStringShouldBeNil {
  XCTAssertNil([WryUtils infoPath:@"" error:nil]);
}

- (void)testInfoPathForStringShouldBeCorrect {
  XCTAssertEqualObjects([WryUtils infoPath:@"test" error:nil], path);
}

- (void)testWritingFileThenReadingShouldGiveSameResult {
  NSString *info = @"test information";
  NSError *error;
  XCTAssertTrue([WryUtils writeInfo:info toFilename:@"test" error:&error]);
  if (error != NULL) {
    NSLog(@"Failed to write: %@", [error userInfo]);
  }
  XCTAssertEqualObjects([WryUtils readInfo:@"test" error:nil], info);
}

- (void)testDeleteRuntimeInfoShouldZeroFiles {
  [WryUtils writeInfo:@"test earliest" toFilename:@"earliest" error:nil];
  [WryUtils writeInfo:@"test latest" toFilename:@"latest" error:nil];
  XCTAssertEqualObjects([WryUtils readInfo:@"earliest" error:nil], @"test earliest");
  XCTAssertEqualObjects([WryUtils readInfo:@"latest" error:nil], @"test latest");
  [WryUtils deleteRuntimeInfo:nil];
  XCTAssertNil([WryUtils readInfo:@"earliest" error:nil]);
  XCTAssertNil([WryUtils readInfo:@"latest" error:nil]);
}

@end
