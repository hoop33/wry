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

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:2
                             errorMessage:@"You must specify a file ID and a filename"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service updateFile:[params objectAtIndex:0] name:[params objectAtIndex:1]
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
