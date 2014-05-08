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

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performListOperation:params
                          minimumParams:0
                           errorMessage:nil
                              formatter:formatter
                                options:options
                                  error:error
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
