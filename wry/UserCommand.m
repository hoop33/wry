//
//  UserCommand.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UserCommand.h"
#import "ADNService.h"
#import "ADNUser.h"

@implementation UserCommand

- (int)run:(WryApplication *)app params:(NSArray *)params {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  ADNUser *user = params.count > 0 ? [service getUser:[params objectAtIndex:0]] : [service getUser];
  return 0;
}

- (void)showHelp {
}

@end
