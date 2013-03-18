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

- (void)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = [service getUnifiedStream:error];
  if (error != nil) {
    for (ADNPost *post in posts) {
      [app println:post];
      [app println:@"--------------------"];
    }
  }
}

- (NSString *)help {
  return @"This is help for the unified command";
}

@end
