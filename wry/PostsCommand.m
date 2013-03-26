//
//  PostsCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "PostsCommand.h"
#import "ADNService.h"
#import "ADNPost.h"

@implementation PostsCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = params.count == 0 ?
    [service getPosts:error] : [service getPosts:[params objectAtIndex:0] error:error];
  if (posts != nil) {
    for (ADNPost *post in posts) {
      [app println:post];
      [app println:@"--------------------"];
    }
    return YES;
  }
  return NO;
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
