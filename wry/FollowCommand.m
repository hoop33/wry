//
//  FollowCommand.m
//  wry
//
//  Created by Rob Warner on 3/20/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FollowCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation FollowCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performSingleParamOperation:app
                                            params:params
                                    successMessage:@"Followed user:"
                                      errorMessage:@"You must specify a user ID or @username to follow"
                                             error:error
                                         operation:(ADNOperationBlock) ^(ADNService *service) {
                                           return [service follow:[params objectAtIndex:0] error:error];
                                         }];
}

- (NSString *)usage {
  return @"<userid | @username>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Follows a user. You must specify either the user's ID or @username.\n"];
  [help appendString:@"Displays the user information for the user you've followed."];
  return help;
}

- (NSString *)summary {
  return @"Follow a user";
}

@end
