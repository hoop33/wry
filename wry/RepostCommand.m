//
//  RepostCommand.m
//  wry
//
//  Created by Rob Warner on 3/22/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "RepostCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation RepostCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performObjectOperation:app
                                       params:params
                                minimumParams:1
                               successMessage:@"Reposted post:"
                                 errorMessage:@"You must specify a post ID"
                                        error:error
                                    operation:(ADNOperationBlock) ^(ADNService *service) {
                                      return [service repost:[params objectAtIndex:0] error:error];
                                    }];
}

- (NSString *)usage {
  return @"<postid>";
}

- (NSString *)help {
  return @"Reposts a post. You must specify the ID of the post you wish to repost.";
}

- (NSString *)summary {
  return @"Repost a post";
}

@end
