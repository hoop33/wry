//
//  BlockCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "BlockCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation BlockCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performObjectOperation:app
                                       params:params
                                minimumParams:1
                               successMessage:@"Blocked user:"
                                 errorMessage:@"You must specify a user ID or @username to block"
                                        error:error
                                    operation:(ADNOperationBlock) ^(ADNService *service) {
                                      return [service block:[params objectAtIndex:0] error:error];
                                    }];
}

- (NSString *)usage {
  return @"<userid | @username>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Blocks a user. You must specify either the user's ID or @username.\n"];
  [help appendString:@"Displays the user information for the user you've blocked."];
  return help;
}

- (NSString *)summary {
  return @"Block a user";
}

@end
