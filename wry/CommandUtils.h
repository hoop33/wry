//
//  CommandUtils.h
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@class ADNUser;
@class ADNService;
@class WryApplication;

typedef id (^ADNOperationBlock)(ADNService *service);

@interface CommandUtils : NSObject

+ (BOOL)performObjectOperation:(WryApplication *)app
                        params:(NSArray *)params
                 minimumParams:(NSInteger)minimumParams
                successMessage:(NSString *)successMessage
                  errorMessage:(NSString *)errorMessage
                         error:(NSError **)error
                     operation:(ADNOperationBlock)operation;

+ (BOOL)performListOperation:(WryApplication *)app
                      params:(NSArray *)params
               minimumParams:(NSInteger)minimumParams
              successMessage:(NSString *)successMessage
                errorMessage:(NSString *)errorMessage
                       error:(NSError **)error
                   operation:(ADNOperationBlock)operation;

@end
