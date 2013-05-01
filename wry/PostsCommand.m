//
//  PostsCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "PostsCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "NSString+Atification.h"

@implementation PostsCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performListOperation:app
                                 params:params
                          minimumParams:0
                           errorMessage:nil error:error
                              operation:^id(ADNService *service) {
                                return params.count > 0 ? [service getPosts:[[params objectAtIndex:0] atify]
                                                                      error:error] :
                                  [service getPosts:error];
                              }];
}

- (NSString *)usage {
  return @"[userid | @username]";
}

- (NSString *)help {
  return @"Displays a user's posts. If no user is specified, displays your posts.";
}

- (NSString *)summary {
  return @"Display a user's posts";
}

@end
