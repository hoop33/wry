//
//  TEXTFormatterTests.m
//  wry
//
//  Created by Rob Warner on 4/28/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TEXTFormatter.h"
#import "ADNPost.h"
#import "ADNResponse.h"
#import "ADNMappingProvider.h"

@interface TEXTFormatterTests : XCTestCase

@end

@implementation TEXTFormatterTests {
  TEXTFormatter *formatter;
}

- (void)setUp
{
  [super setUp];
  formatter = [[TEXTFormatter alloc] init];
}

- (void)tearDown
{
  formatter = nil;
  [super tearDown];
}

- (void)testPostsOutputShouldShowRange {
  NSData *data = [NSData dataWithContentsOfFile:[self resourcePath:@"posts.json"]];
  ADNResponse *response = [[ADNResponse alloc] initWithData:data mapping:[ADNMappingProvider postMapping] reverse:NO error:nil];
  NSString *output = [formatter format:response];
  XCTAssertNotEqual([output rangeOfString:@"2 items (29154298 - 29269343)"].location, NSNotFound, @"The range of posts should be in the output");
}

- (void)testPostOutputRangeShouldShowSingleItem {
  NSData *data = [NSData dataWithContentsOfFile:[self resourcePath:@"post.json"]];
  ADNResponse *response = [[ADNResponse alloc] initWithData:data mapping:[ADNMappingProvider postMapping] reverse:NO error:nil];
  NSString *output = [formatter format:response];
  XCTAssertNotEqual([output rangeOfString:@"1 item (29415319)"].location, NSNotFound, @"The single post should be in the output");
}

- (void)testPostOutputWithEmptyStringShouldBeEmpty {
  NSData *data = [@"" dataUsingEncoding:NSUTF8StringEncoding];
  ADNResponse *response = [[ADNResponse alloc] initWithData:data mapping:nil reverse:NO error:nil];
  NSString *output = [formatter format:response];
  XCTAssertEqualObjects(output, @"", @"Empty string should format to empty string");
}

- (NSString *)resourcePath:(NSString *)filename {
  return [NSString stringWithFormat:@"%@/%@", [[NSBundle bundleForClass:[self class]] resourcePath], filename];
}

@end
