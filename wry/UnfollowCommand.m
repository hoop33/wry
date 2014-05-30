//
//  UnfollowCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UnfollowCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "NSString+Prefix.h"

@implementation UnfollowCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a user ID or @username to unfollow"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service unfollow:[[params objectAtIndex:0] atify] error:error];
                                }];
}

- (NSString *)usage {
  return @"<userid | @username>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Unfollows a user. You must specify either the user's ID or @username.\n"];
  [help appendString:@"Displays the user information for the user you've unfollowed."];
  return help;
}

- (NSString *)summary {
  return @"Unfollow a user";
}

@end
