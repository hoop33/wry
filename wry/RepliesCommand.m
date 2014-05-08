//
//  RepliesCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RepliesCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation RepliesCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performListOperation:params
                          minimumParams:1
                           errorMessage:@"You must specify a post ID"
                              formatter:formatter
                                options:options
                                  error:error
                              operation:(ADNOperationBlock) ^(ADNService *service) {
                                return [service getReplies:[params objectAtIndex:0] error:error];
                              }];
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Displays the replies to a post. You must specify the ID of the post you wish to see replies for.";
}

- (NSString *)summary {
  return @"Display the replies to a post";
}

@end
