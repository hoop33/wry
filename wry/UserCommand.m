//
//  UserCommand.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UserCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation UserCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:0
                             errorMessage:nil error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return params.count > 0 ? [service getUser:[params objectAtIndex:0]
                                                                       error:error] :
                                    [service getUser:error];
                                }];
}

- (NSString *)usage {
  return @"[userid | @username]";
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
