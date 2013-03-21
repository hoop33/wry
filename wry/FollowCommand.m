//
//  FollowCommand.m
//  wry
//
//  Created by Rob Warner on 3/20/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FollowCommand.h"
#import "ADNService.h"
#import "ADNUser.h"
#import "WryErrorCodes.h"

@implementation FollowCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a user name or ID to follow."}];
    }
    return NO;
  }
  ADNService *service = [[ADNService alloc] initWithApplication:app];
  ADNUser *user = [service follow:[params objectAtIndex:0] error:error];
  if (user != nil) {
    [app println:@"You are now following:"];
    [app println:user];
    return YES;
  }
  return NO;
}

- (NSString *)help {
  return @"This is the help for the following command";
}

- (NSString *)summary {
  return @"This is the summary for the following command";
}

@end
