//
//  RepliesCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RepliesCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation RepliesCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performListOperation:app
                                     params:params
                              minimumParams:1
                             successMessage:@"Replies:"
                               errorMessage:@"You must specify a post ID"
                                      error:error
                                  operation:(ADNOperationBlock) ^(ADNService *service) {
                                    return [service getReplies:[params objectAtIndex:0] error:error];
                                  }];
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Displays the replies to a post. You must specify the ID of the post you wish to see replies for.";
}

- (NSString *)summary {
  return @"Display the replies to a post";
}

@end
