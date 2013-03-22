//
//  UnifiedCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UnifiedCommand.h"
#import "ADNService.h"
#import "ADNPost.h"

@implementation UnifiedCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = [service getUnifiedStream:error];
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
  return @"unified";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Displays your unified stream, which contains the most recent posts from\n"];
  [help appendString:@"the users you follow, mixed with the posts you're mentioned in."];
  return help;
}

- (NSString *)summary {
  return @"Display the current user's unified stream";
}

@end
