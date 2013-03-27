//
//  CommandUtils.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "CommandUtils.h"
#import "WryApplication.h"
#import "ADNUser.h"
#import "WryErrorCodes.h"
#import "ADNService.h"

@implementation CommandUtils

+ (BOOL)performUserOperation:(WryApplication *)app
                      params:(NSArray *)params
              successMessage:(NSString *)successMessage
                errorMessage:(NSString *)errorMessage
                       error:(NSError **)error
                   operation:(ADNUserOperationBlock)operation {
  BOOL success = YES;
  if (params.count == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    }
    success = NO;
  } else {
    ADNService *service = [[ADNService alloc] initWithApplication:app];
    ADNUser *user = operation(service);
    if (user != nil) {
      if (successMessage != nil) {
        [app println:successMessage];
      }
      [app println:user];
    } else {
      success = NO;
    }
  }
  return success;
}

@end
