//
//  LsCommand.m
//  wry
//
//  Created by Rob Warner on 04/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "LsCommand.h"
#import "WryUtils.h"
#import "ADNService.h"

@implementation LsCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performListOperation:app
                                 params:params
                          minimumParams:0
                           errorMessage:nil error:error
                              operation:^id(ADNService *service) {
                                return [service getFiles:error];
                              }];
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Lists the files you have stored on App.net";
}

- (NSString *)summary {
  return @"Get a file listing";
}

@end
