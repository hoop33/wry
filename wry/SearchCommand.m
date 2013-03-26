//
//  SearchCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "SearchCommand.h"
#import "ADNService.h"
#import "WryErrorCodes.h"
#import "ADNPost.h"

@implementation SearchCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  BOOL success = YES;
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a hashtag to search for"}];
    }
    success = NO;
  } else {
    NSString *hashtag = [params objectAtIndex:0];
    if (hashtag.length > 0 && [hashtag hasPrefix:@"#"]) {
      hashtag = [hashtag substringFromIndex:1];
    }
    ADNService *service = [[ADNService alloc] initWithApplication:app];
    NSArray *posts = [service searchPosts:hashtag error:error];
    if (posts != nil) {
      for (ADNPost *post in posts) {
        [app println:post];
        [app println:@"--------------------"];
      }
    } else {
      success = NO;
    }
  }
  return success;
}

- (NSString *)usage {
  return @"<hashtag>";
}

- (NSString *)help {
  return @"Searches posts for the specified hashtag.";
}

- (NSString *)summary {
  return @"Search for hashtag";
}

@end
