//
//  MuteCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MuteCommand.h"
#import "WryErrorCodes.h"
#import "ADNService.h"
#import "ADNUser.h"

@implementation MuteCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a user name or ID to mute."}];
    }
    return NO;
  }
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  ADNUser *user = [service mute:[params objectAtIndex:0] error:error];
  if (user != nil) {
    [app println:@"Muted user:"];
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
  [help appendString:@"Mutes a user. You must specify either the user's ID or @username.\n"];
  [help appendString:@"Displays the user information for the user you've muted."];
  return help;
}

- (NSString *)summary {
  return @"Mute a user";
}

@end
