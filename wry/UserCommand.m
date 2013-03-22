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

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  ADNUser *user = params.count > 0 ? [service getUser:[params objectAtIndex:0] error:error] : [service getUser:error];
  if (user != nil) {
    [app println:user];
    return YES;
  }
  return NO;
}

- (NSString *)usage {
  return @"user [userid | @username]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Displays information about a user. If you specify a user ID or @username,\n"];
  [help appendString:@"displays information about that user. Otherwise, displays information\n"];
  [help appendString:@"about yourself."];
  return help;
}

- (NSString *)summary {
  return @"Display information about a user";
}

@end
