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
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:2
                             errorMessage:@"You must specify a message and a user to send to"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  NSMutableArray *users = [NSMutableArray array];
                                  NSString *replyID = nil;
                                  for (NSUInteger i = 0, n = params.count - 1; i < n; i++) {
                                    NSString *param = [params objectAtIndex:i];
                                    if ([param hasPrefix:@"@"]) {
                                      [users addObject:param];
                                    } else {
                                      replyID = param;
                                    }
                                  }
                                  return [service sendMessage:users replyID:replyID
                                                    channelID:nil text:[params lastObject]
                                                        error:error];
                              }];
}

- (NSString *)usage {
  return @"<@username1 @username2 @username3 ...> [messageid] <text>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Sends a private message to the specified user or users. You can specify\n"];
  [help appendString:@"multiple users by separating with spaces. You can also reply to a message\n"];
  [help appendString:@"by specifying the ID of the message to reply to."];
  return help;
}

- (NSString *)summary {
  return @"Send a private message";
}

@end
