//
//  FindCommand.m
//  wry
//
//  Created by Rob Warner on 3/28/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FindCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation FindCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performListOperation:app
                                     params:params
                              minimumParams:1
                             successMessage:@"Users:"
                               errorMessage:@"You must specify a search string"
                                      error:error
                                  operation:^id(ADNService *service) {
                                    return [service searchUsers:[[params componentsJoinedByString:@" "]
                                                                         stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                                          error:error];
                                  }];
}

- (NSString *)usage {
  return @"<search string>";
}

- (NSString *)help {
  NSMutableString *help = [NSMutableString string];
  [help appendString:@"Finds users that match the specified search string. The search string can be\n"];
  [help appendString:@"a @username or search terms. Searches @usernames, names, and bios."];
  return help;
}

- (NSString *)summary {
  return @"Finds users";
}

@end
