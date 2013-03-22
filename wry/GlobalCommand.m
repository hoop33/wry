//
//  GlobalCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "GlobalCommand.h"
#import "ADNService.h"
#import "ADNPost.h"

@implementation GlobalCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = [service getGlobalStream:error];
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
  return @"global";
}

- (NSString *)help {
  return @"Displays the global stream, which contains the most recent posts from all users.";
}

- (NSString *)summary {
  return @"Display the global stream";
}

@end
