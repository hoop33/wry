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

typedef ADNUser *(^ADNUserOperationBlock)(ADNService *service);

@interface CommandUtils : NSObject

+ (BOOL)performUserOperation:(WryApplication *)app
                      params:(NSArray *)params
              successMessage:(NSString *)successMessage
                errorMessage:(NSString *)errorMessage
                       error:(NSError **)error
                   operation:(ADNUserOperationBlock)operation;

@end
