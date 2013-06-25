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

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  return params.count > 0 ?
    [WryUtils performObjectOperation:params
                       minimumParams:0
                        errorMessage:nil error:error
                           operation:^id(ADNService *service) {
                             return [service getFile:[params objectAtIndex:0] error:error];
                           }] :
    [WryUtils performListOperation:params
                     minimumParams:0
                      errorMessage:nil error:error
                         operation:^id(ADNService *service) {
                           return [service getFiles:error];
                         }];
}

- (NSString *)usage {
  return @"[file ID]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Displays information about a file. If you specify a file ID,\n"];
  [help appendString:@"displays information about that file. Otherwise, displays information\n"];
  [help appendString:@"about all your files."];
  return help;
}

- (NSString *)summary {
  return @"Get a file listing";
}

@end
