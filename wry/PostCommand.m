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
                               userInfo:@{NSLocalizedDescriptionKey : @"You must supply either a post ID or a message"}];
    }
    success = NO;
  } else {
    NSString *text = [params componentsJoinedByString:@" "];
    ADNPost *post = [service createPost:text error:error];
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
  return @"Creates or displays a Post";
}

@end
