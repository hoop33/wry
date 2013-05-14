//
//  ChannelCommand.m
//  wry
//
//  Created by Rob Warner on 5/14/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ChannelCommand.h"
#import "WryUtils.h"
#import "ADNService.h"

@implementation ChannelCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:1
                             errorMessage:@"You must specify a channel ID"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                          return [service getChannel:[params objectAtIndex:0]
                                                                               error:error];
                                }];
}

- (NSString *)usage {
  return @"<channelid>";
}

- (NSString *)help {
  return @"Displays information about a channel. You must specify a channel ID.";
}

- (NSString *)summary {
  return @"Display information about a channel";
}

@end
