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

@implementation PostCommand

- (void)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  if (params.count == 0) {
    // TODO Show help?
  } else if (params.count == 1 && NO) {
    // TODO and is numeric -- get post
  } else {
    NSString *text = [params componentsJoinedByString:@" "];
    ADNPost *post = [service createPost:text error:error];
    if (error != nil) {
      [app println:post];
    }
  }
}

- (NSString *)help {
  return @"This is help for the post command";
}

@end
