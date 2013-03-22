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

- (NSString *)help {
  return @"This is help for the unified command";
}

- (NSString *)summary {
  return @"Display the current user's unified stream";
}

@end
