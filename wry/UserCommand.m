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

- (void)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  ADNUser *user = params.count > 0 ? [service getUser:[params objectAtIndex:0] error:error] : [service getUser:error];
  if (user != nil) {
    [app println:user];
  }
}

- (NSString *)help {
  return @"This is help for the user command";
}

@end
