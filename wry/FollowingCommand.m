//
//  FollowingCommand.m
//  wry
//
//  Created by Rob Warner on 3/20/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FollowingCommand.h"
#import "ADNService.h"
#import "ADNUser.h"

@implementation FollowingCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *following = params.count > 0 ? [service getFollowing:[params objectAtIndex:0]
                                                          error:error] : [service getFollowing:error];
  if (following != nil) {
    for (ADNUser *follow in following) {
      [app println:follow];
      [app println:@"--------------------"];
    }
    return YES;
  }
  return NO;
}

- (NSString *)usage {
  return @"following [userid | @username]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Lists users a user is following. You can specify either the user's ID or\n"];
  [help appendString:@"@username to list users that user is following. If you don't specify a user ID\n"];
  [help appendString:@"or @username, lists users you're following."];
  return help;
}

- (NSString *)summary {
  return @"List the users a user is following";
}

@end
