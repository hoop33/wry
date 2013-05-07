//
//  SendCommand.m
//  wry
//
//  Created by Rob Warner on 05/07/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "SendCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation SendCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performListOperation:app
                                 params:params
                          minimumParams:0
                           errorMessage:nil
                                  error:error
                              operation:^id(ADNService *service) {
                                return (params.count == 0) ?
                                  [service getMessages:error] :
                                  [service getMessages:[params objectAtIndex:0] error:error];
                              }];
}

- (NSString *)usage {
  return @"<user1,user2,user3> <text>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Sends a private message to the specified user or users. You can\n"];
  [help appendString:@"specify multiple users by separating with commas."];
  return help;
}

- (NSString *)summary {
  return @"Send a private message";
}

@end
