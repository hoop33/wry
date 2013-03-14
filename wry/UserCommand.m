//
//  UserCommand.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UserCommand.h"
#import "ADNService.h"

@implementation UserCommand

- (int)run:(WryApplication *)app params:(NSArray *)params {
  NSLog(@"Getting user");
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  [service getUser];
  return 0;
}

- (void)showHelp {
}

@end
