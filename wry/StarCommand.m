//
//  StarCommand.m
//  wry
//
//  Created by Rob Warner on 3/22/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "StarCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation StarCommand

// TODO refactor these common methods
- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:1
                             errorMessage:@"You must specify a post ID"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service star:[params objectAtIndex:0] error:error];
                                }];
}

- (NSString *)usage {
  return @"<postid>";
}

- (NSString *)help {
  return @"Stars a post. You must specify the ID of the post you wish to star.";
}

- (NSString *)summary {
  return @"Star a post";
}

@end
