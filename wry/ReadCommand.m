//
//  ReadCommand.m
//  wry
//
//  Created by Rob Warner on 3/25/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ReadCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation ReadCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a post ID"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service showPost:[params objectAtIndex:0] error:error];
                                }];
}

- (NSString *)usage {
  return @"<postid>";
}

- (NSString *)help {
  return @"Reads a post. You must specify the ID of the post you wish to read.";
}

- (NSString *)summary {
  return @"Read a post";
}

@end
