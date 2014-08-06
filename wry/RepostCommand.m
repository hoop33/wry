//
//  RepostCommand.m
//  wry
//
//  Created by Rob Warner on 3/22/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RepostCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation RepostCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a post ID"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service repost:params[0] error:error];
                                }];
}

- (NSString *)usage {
  return @"<postid>";
}

- (NSString *)help {
  return @"Reposts a post. You must specify the ID of the post you wish to repost.";
}

- (NSString *)summary {
  return @"Repost a post";
}

@end
