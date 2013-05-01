//
//  FollowersCommand.m
//  wry
//
//  Created by Rob Warner on 3/20/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FollowersCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "NSString+Atification.h"

@implementation FollowersCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performListOperation:app
                                 params:params
                          minimumParams:0
                           errorMessage:nil error:error
                              operation:^id(ADNService *service) {
                                return params.count > 0 ? [service getFollowers:[[params objectAtIndex:0] atify]
                                                                          error:error] :
                                  [service getFollowers:error];
                              }];
}

- (NSString *)usage {
  return @"[userid | @username]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Lists a user's followers. You can specify either the user's ID or @username\n"];
  [help appendString:@"to list followers for that user. If you don't specify a user ID or @username,\n"];
  [help appendString:@"lists your followers."];
  return help;
}

- (NSString *)summary {
  return @"List the users following a user";
}

@end
