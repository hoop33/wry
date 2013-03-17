//
//  GlobalCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "GlobalCommand.h"
#import "ADNService.h"
#import "ADNPost.h"

@implementation GlobalCommand

- (int)run:(WryApplication *)app params:(NSArray *)params {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *posts = [service getGlobalStream];
  for (ADNPost *post in posts) {
    [app println:post];
    [app println:@"--------------------"];
  }
  return 0;
}

- (void)showHelp {
}

@end
