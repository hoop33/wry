//
//  DownloadCommand.m
//  wry
//
//  Created by Rob Warner on 04/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "DownloadCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation DownloadCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a file ID to download"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service download:[params objectAtIndex:0] error:error];
                                }];
}

- (NSString *)usage {
  return @"<fileid>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Downloads the file with the file ID you specify and saves it in the\n"];
  [help appendString:@"current directory."];
  return help;
}

- (NSString *)summary {
  return @"Download a file";
}

@end
