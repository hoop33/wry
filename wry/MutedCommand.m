//
//  MutedCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MutedCommand.h"
#import "ADNService.h"
#import "ADNUser.h"

@implementation MutedCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  NSArray *muteds = params.count > 0 ? [service getMuted:[params objectAtIndex:0]
                                                   error:error] : [service getMuted:error];
  if (muteds != nil) {
    for (ADNUser *muted in muteds) {
      [app println:muted];
      [app println:@"--------------------"];
    }
    return YES;
  }
  return NO;
}

- (NSString *)usage {
  return @"[userid | @username]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Lists the users that a user has muted. You can specify either the user's ID\n"];
  [help appendString:@"or @username to list the muted users for that user. If you don't specify\n"];
  [help appendString:@"a user ID or @username, lists the users you have muted."];
  return help;
}

- (NSString *)summary {
  return @"List the users that a user has muted";
}

@end
