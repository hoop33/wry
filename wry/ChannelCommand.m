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

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a channel ID"
                                formatter:formatter
                                  options:options
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
