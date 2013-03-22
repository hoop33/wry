//
//  ReplyCommand.m
//  wry
//
//  Created by Rob Warner on 3/21/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ReplyCommand.h"
#import "ADNService.h"
#import "ADNPost.h"
#import "WryErrorCodes.h"

@implementation ReplyCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  BOOL success = YES;
  if (params.count < 2) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify the Post ID to reply to and a message"}];
    }
    success = NO;
  } else {
    ADNService *service = [[ADNService alloc] initWithApplication:app];
    NSString *replyID = [params objectAtIndex:0];
    NSString *text = [[params subarrayWithRange:NSMakeRange(1, params.count - 1)] componentsJoinedByString:@" "];
    ADNPost *post = [service createPost:text replyID:replyID error:error];
    if (post != nil) {
      [app println:post];
    } else {
      success = NO;
    }
  }
  return success;
}

- (NSString *)help {
  return @"This is help for the post command";
}

- (NSString *)summary {
  return @"Reply to a post";
}

@end
