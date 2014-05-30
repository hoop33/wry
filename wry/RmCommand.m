//
//  RmCommand.m
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

#import "RmCommand.h"
#import "WryUtils.h"
#import "ADNService.h"

@implementation RmCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a file ID"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service deleteFile:params[0] error:error];
                                }];
}

- (NSString *)usage {
  return @"<fileid>";
}

- (NSString *)help {
  return @"Deletes the file with the file ID you specify.";
}

- (NSString *)summary {
  return @"Delete a file";
}

@end
