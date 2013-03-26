//
//  UnblockCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UnblockCommand.h"
#import "WryErrorCodes.h"
#import "ADNService.h"
#import "ADNUser.h"

@implementation UnblockCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a user name or ID to unblock."}];
    }
    return NO;
  }
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  ADNUser *user = [service unblock:[params objectAtIndex:0] error:error];
  if (user != nil) {
    [app println:@"Unblocked user:"];
    [app println:user];
    return YES;
  }
  return NO;
}

- (NSString *)usage {
  return @"<userid | @username>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Unblocks a user. You must specify either the user's ID or @username.\n"];
  [help appendString:@"Displays the user information for the user you've unblocked."];
  return help;
}

- (NSString *)summary {
  return @"Unblock a user";
}

@end
