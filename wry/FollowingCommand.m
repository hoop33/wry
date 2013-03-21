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

- (NSString *)help {
  return @"This is the help for the following command";
}

- (NSString *)summary {
  return @"This is the summary for the following command";
}

@end
