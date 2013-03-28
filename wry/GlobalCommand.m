//
//  GlobalCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "GlobalCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation GlobalCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performListOperation:app
                             successMessage:@"Global stream:"
                                      error:error
                                  operation:^id(ADNService *service) {
                                    return [service getGlobalStream:error];
                                  }];
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Displays the global stream, which contains the most recent posts from all users.";
}

- (NSString *)summary {
  return @"Display the global stream";
}

@end
