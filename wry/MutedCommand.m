//
//  MutedCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MutedCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "NSString+Prefix.h"

@implementation MutedCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performListOperation:params
                          minimumParams:0
                           errorMessage:nil
                              formatter:formatter
                                options:options
                                  error:error
                              operation:^id(ADNService *service) {
                                return params.count > 0 ? [service getMuted:[[params objectAtIndex:0] atify]
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
