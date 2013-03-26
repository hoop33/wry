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
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify the text to post"}];
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
  return @"<text>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Creates a new post with the text you specify. Note that the shell's parsing\n"];
  [help appendString:@"rules are respected, so escape your text appropriately. Quotes are optional."];
  return help;
}

- (NSString *)summary {
  return @"Create a post";
}

@end
