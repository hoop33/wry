//
//  MuteCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MuteCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "NSString+Atification.h"

@implementation MuteCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:1
                             errorMessage:@"You must specify a user ID or @username to mute"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service mute:[[params objectAtIndex:0] atify] error:error];
                                }];
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
