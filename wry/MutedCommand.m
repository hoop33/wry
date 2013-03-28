//
//  MutedCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MutedCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation MutedCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performListOperation:app
                                     params:params
                              minimumParams:0
                             successMessage:@"Muted:"
                               errorMessage:nil
                                      error:error
                                  operation:^id(ADNService *service) {
                                    return params.count > 0 ? [service getMuted:[params objectAtIndex:0]
                                                                          error:error] :
                                      [service getMuted:error];
                                  }];
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
