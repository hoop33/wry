//
//  RepliesCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RepliesCommand.h"
#import "ADNService.h"
#import "ADNPost.h"
#import "WryErrorCodes.h"

@implementation RepliesCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a post ID."}];
    }
    return NO;
  }
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = [service getReplies:[params objectAtIndex:0] error:error];
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
  return @"";
}

- (NSString *)help {
  return @"Displays the replies to a post. You must specify the ID of the post you wish to see replies for.";
}

- (NSString *)summary {
  return @"Display the replies to a post";
}

@end
