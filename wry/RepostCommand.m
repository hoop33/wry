//
//  RepostCommand.m
//  wry
//
//  Created by Rob Warner on 3/22/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RepostCommand.h"
#import "ADNService.h"
#import "ADNPost.h"
#import "WryErrorCodes.h"

@implementation RepostCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  BOOL success = YES;
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a post ID"}];
    }
    success = NO;
  } else {
    ADNPost *post = [service repost:[params objectAtIndex:0] error:error];
    if (post != nil) {
      [app println:@"Reposted post:"];
      [app println:post];
    } else {
      success = NO;
    }
  }
  return success;
}

- (NSString *)usage {
  return @"<postid>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Reposts a post. You must specify the ID of the post you wish to repost."];
  return help;
}

- (NSString *)summary {
  return @"Repost a post";
}

@end
