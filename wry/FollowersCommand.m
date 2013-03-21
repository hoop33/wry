//
//  FollowersCommand.m
//  wry
//
//  Created by Rob Warner on 3/20/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FollowersCommand.h"
#import "ADNService.h"
#import "ADNUser.h"

@implementation FollowersCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *followers = params.count > 0 ? [service getFollowers:[params objectAtIndex:0] error:error] : [service getFollowers:error];
  if (followers != nil) {
    for (ADNUser *follower in followers) {
      [app println:follower];
      [app println:@"--------------------"];
    }
    return YES;
  }
  return NO;
}

- (NSString *)help {
  return @"This is the help for the followers command";
}

- (NSString *)summary {
  return @"This is the summary for the followers command";
}

@end
