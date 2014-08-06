//
//  MvCommand.m
//  wry
//
//  Created by Rob Warner on 6/6/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "MvCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation MvCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:2
                             errorMessage:@"You must specify a file ID and a filename"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service updateFile:params[0] name:params[1]
                                                  makePublic:nil error:error];
                                }];
}

- (NSString *)usage {
  return @"<fileid> <filename>";
}

- (NSString *)help {
  return @"Renames a file. You must specify a file ID and a filename.";
}

- (NSString *)summary {
  return @"Rename a file";
}

@end
