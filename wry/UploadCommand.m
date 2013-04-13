//
//  UploadCommand.m
//  wry
//
//  Created by Rob Warner on 04/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UploadCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "WryErrorCodes.h"

@implementation UploadCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a file name to upload"}];
    }
    return NO;
  }
  NSString *filename = [params objectAtIndex:0];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSData *data = [fileManager contentsAtPath:filename];
  if (data == nil) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ does not exist",
                                                                                                 filename]}];
    }
    return NO;
  }
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:0
                             errorMessage:nil error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  return [service upload:filename content:data error:error];
                                }];
}

- (NSString *)usage {
  return @"<path to file>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Uploads the file you specify. You can specify a full or a relative\n"];
  [help appendString:@"path to the file you wish to upload."];
  return help;
}

- (NSString *)summary {
  return @"Upload a file";
}

@end
