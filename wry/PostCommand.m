//
//  PostCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "PostCommand.h"
#import "ADNService.h"
#import "ADNPost.h"
#import "WryErrorCodes.h"

@implementation PostCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  BOOL success = YES;
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  // TODO If an ID, GET the post
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify either a post ID or a message"}];
    }
    success = NO;
  } else {
    NSString *text = [params componentsJoinedByString:@" "];
    ADNPost *post = [service createPost:text replyID:nil error:error];
    if (post != nil) {
      [app println:post];
    } else {
      success = NO;
    }
  }
  return success;
}

- (NSString *)usage {
  return @"post [postid | message]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"If you specify a post ID, displays that post. If you specify a message, creates\n"];
  [help appendString:@"a new post with the message text. Note that the shell's parsing rules are\n"];
  [help appendString:@"respected, so escape your text appropriately. Quotes are optional."];
  return help;
}

- (NSString *)summary {
  return @"Create or display a post";
}

@end
