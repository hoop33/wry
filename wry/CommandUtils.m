//
//  CommandUtils.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "CommandUtils.h"
#import "WryApplication.h"
#import "WryErrorCodes.h"
#import "ADNService.h"

@interface CommandUtils ()
+ (BOOL)performOperation:(WryApplication *)app
                  params:(NSArray *)params
           minimumParams:(NSInteger)minimumParams
          successMessage:(NSString *)successMessage
            errorMessage:(NSString *)errorMessage
                   error:(NSError **)error
               operation:(ADNOperationBlock)operation
         outputOperation:(ADNOutputOperationBlock)outputOperation;
@end

@implementation CommandUtils

+ (BOOL)performObjectOperation:(WryApplication *)app
                        params:(NSArray *)params
                 minimumParams:(NSInteger)minimumParams
                successMessage:(NSString *)successMessage
                  errorMessage:(NSString *)errorMessage
                         error:(NSError **)error
                     operation:(ADNOperationBlock)operation {
  return [CommandUtils performOperation:app
                                 params:params
                          minimumParams:minimumParams
                         successMessage:successMessage
                           errorMessage:errorMessage
                                  error:error
                              operation:operation
                        outputOperation:(ADNOutputOperationBlock) ^(NSObject *response) {
                          if (successMessage != nil) {
                            [app println:successMessage];
                          }
                          [app println:response];
                        }];
}

+ (BOOL)performListOperation:(WryApplication *)app
                      params:(NSArray *)params
               minimumParams:(NSInteger)minimumParams
              successMessage:(NSString *)successMessage
                errorMessage:(NSString *)errorMessage
                       error:(NSError **)error
                   operation:(ADNOperationBlock)operation {
  return [CommandUtils performOperation:app
                                 params:params
                          minimumParams:minimumParams
                         successMessage:successMessage
                           errorMessage:errorMessage
                                  error:error
                              operation:operation
                        outputOperation:(ADNOutputOperationBlock) ^(NSObject *response) {
                          NSArray *list = (NSArray *) response;
                          if (list.count > 0) {
                            if (successMessage != nil) {
                              [app println:successMessage];
                            }
                            for (id item in list) {
                              [app println:item];
                              [app println:@"----------"];
                            }
                          }
                        }];
}

+ (BOOL)performOperation:(WryApplication *)app
                  params:(NSArray *)params
           minimumParams:(NSInteger)minimumParams
          successMessage:(NSString *)successMessage
            errorMessage:(NSString *)errorMessage
                   error:(NSError **)error
               operation:(ADNOperationBlock)operation
         outputOperation:(ADNOutputOperationBlock)outputOperation {
  BOOL success = YES;
  if (params.count < minimumParams) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    }
    success = NO;
  } else {
    ADNService *service = [[ADNService alloc] initWithApplication:app];
    NSObject *adnResponse = operation(service);
    if (adnResponse != nil) {
      outputOperation(adnResponse);
    } else {
      // Service might have supplied an error; if not, supply one
      if (error != NULL && *error == nil) {
        *error = [NSError errorWithDomain:app.errorDomain
                                     code:WryErrorCodeUnknown
                                 userInfo:@{NSLocalizedDescriptionKey : @"The operation was unsuccessful"}];
      }
      success = NO;
    }
  }
  return success;
}
@end
