//
//  MessageCommand.m
//  wry
//
//  Created by Rob Warner on 5/1/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "MessageCommand.h"
#import "WryUtils.h"
#import "ADNService.h"

@implementation MessageCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:2
                             errorMessage:@"You must specify a message ID and a channel ID"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service getMessage:params[0] channelID:params[1] error:error];
                                }];
}

- (NSString *)usage {
  return @"[message ID] [channel ID]";
}

- (NSString *)help {
  return @"Reads a message. You must specify the message ID and channel ID.";
}

- (NSString *)summary {
  return @"Read a message";
}

@end
