//
//  ChannelsCommand.m
//  wry
//
//  Created by Rob Warner on 5/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ChannelsCommand.h"
#import "WryUtils.h"
#import "ADNService.h"

@implementation ChannelsCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performListOperation:app
                                 params:params
                          minimumParams:0
                           errorMessage:nil error:error
                              operation:^id(ADNService *service) {
                                return [service getChannels:error];
                              }];
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Displays your subscribed channels.";
}

- (NSString *)summary {
  return @"Display your subscribed channels";
}

@end
