//
//  ChmodCommand.m
//  wry
//
//  Created by Rob Warner on 6/6/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ChmodCommand.h"
#import "ADNService.h"
#import "WryUtils.h"

@implementation ChmodCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:2
                             errorMessage:@"You must specify a file ID and either 'public' or 'private'"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  NSNumber *makePublic = [[params objectAtIndex:1] isEqualTo:@"public"] ? @YES : @NO;
                                  return [service updateFile:[params objectAtIndex:0] name:nil
                                                  makePublic:makePublic error:error];
                                }];
}

- (NSString *)usage {
  return @"<fileid> <public | private>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
          @"Changes the permissions on a file. You must specify a file ID\n"
            @"and either 'public' or 'private'."];
  return help;
}

- (NSString *)summary {
  return @"Change the permissions on a file";
}

@end
