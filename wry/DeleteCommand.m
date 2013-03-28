//
//  DeleteCommand.m
//  wry
//
//  Created by Rob Warner on 3/22/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "DeleteCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation DeleteCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performObjectOperation:app
                                       params:params
                                minimumParams:1
                               successMessage:@"Deleted post:"
                                 errorMessage:@"You must specify a post ID"
                                        error:error
                                    operation:(ADNOperationBlock) ^(ADNService *service) {
                                      return [service delete:[params objectAtIndex:0] error:error];
                                    }];
}

- (NSString *)usage {
  return @"<postid>";
}

- (NSString *)help {
  return @"Deletes a post. You must specify the ID of the post you wish to delete.";
}

- (NSString *)summary {
  return @"Delete a post";
}

@end
