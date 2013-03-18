//
//  StreamCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "StreamCommand.h"
#import "ADNService.h"
#import "ADNPost.h"

@implementation StreamCommand

- (void)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = [service getUserStream:error];
  if (error != nil) {
    for (ADNPost *post in posts) {
      [app println:post];
      [app println:@"--------------------"];
    }
  }
}

- (NSString *)help {
  return @"This is help for the stream command";
}

@end
