//
//  MessagesCommand.m
//  wry
//
//  Created by Rob Warner on 05/06/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MessagesCommand.h"
#import "WryUtils.h"
#import "ADNService.h"

@implementation MessagesCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performListOperation:params
                          minimumParams:0
                           errorMessage:nil
                              formatter:formatter
                                options:options
                                  error:error
                              operation:^id(ADNService *service) {
                                return (params.count == 0) ?
                                  [service getMessages:error] :
                                  [service getMessages:params[0] error:error];
                              }];
}

- (NSString *)usage {
  return @"[channelid]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Displays messages. If you specify a channel ID, shows the messages in that\n"];
  [help appendString:@"channel. Otherwise, shows your messages."];
  return help;
}

- (NSString *)summary {
  return @"Display messages";
}

@end
