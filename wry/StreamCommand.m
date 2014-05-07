//
//  StreamCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "StreamCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation StreamCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performListOperation:params
                          minimumParams:0
                           errorMessage:nil
                              formatter:formatter
                                options:options
                                  error:error
                              operation:^id(ADNService *service) {
                                return [service getUserStream:error];
                              }];
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Displays your stream, which contains the most recent posts from the users\n"];
  [help appendString:@"you follow."];
  return help;
}

- (NSString *)summary {
  return @"Display the current user's stream";
}

@end
