//
//  SendCommand.m
//  wry
//
//  Created by Rob Warner on 5/14/13.
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
                             errorMessage:@"You must specify a message and a channel to send to"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service sendMessage:nil replyID:nil
                                                    channelID:[params objectAtIndex:0] text:[params objectAtIndex:1]
                                                        error:error];
                                }];
}

- (NSString *)usage {
  return @"<channelid> <text>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Sends a message to the specified channel. You must specify both the channel\n"];
  [help appendString:@"and the text of the message."];
  return help;
}

- (NSString *)summary {
  return @"Send a message to a channel";
}

@end
