//
//  UnblockCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UnblockCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation UnblockCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performSingleParamOperation:app
                                            params:params
                                    successMessage:@"Unblocked user:"
                                      errorMessage:@"You must specify a user ID or @username to unblock"
                                             error:error
                                         operation:(ADNOperationBlock) ^(ADNService *service) {
                                           return [service unblock:[params objectAtIndex:0] error:error];
                                         }];
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
