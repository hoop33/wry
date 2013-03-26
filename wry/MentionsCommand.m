//
//  MentionsCommand.m
//  wry
//
//  Created by Rob Warner on 3/25/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MentionsCommand.h"
#import "ADNService.h"
#import "ADNPost.h"

@implementation MentionsCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = params.count == 0 ? [service getMentions:error] : [service getMentions:[params objectAtIndex:0]
                                                                                    error:error];
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
  return @"Displays the mentions for a user. If no user is specified, displays your mentions.";
}

- (NSString *)summary {
  return @"Display the mentions for a user";
}

@end
