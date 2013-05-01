//
//  WryUtils.h
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryCommand.h"
#import "WryFormatter.h"

@class ADNUser;
@class ADNService;
@class WryApplication;

typedef id (^ADNOperationBlock)(ADNService *service);
typedef void (^ADNOutputOperationBlock)(NSObject *response);

@interface WryUtils : NSObject

+ (BOOL)getADNResponseForOperation:(WryApplication *)app
                       accessToken:(NSString *)accessToken
                            params:(NSArray *)params
                     minimumParams:(NSInteger)minimumParams
                      errorMessage:(NSString *)errorMessage
                             error:(NSError **)error
                          response:(ADNResponse **)adnResponse
                         operation:(ADNOperationBlock)operation;

+ (BOOL)performObjectOperation:(WryApplication *)app
                        params:(NSArray *)params
                 minimumParams:(NSInteger)minimumParams
                  errorMessage:(NSString *)errorMessage
                         error:(NSError **)error
                     operation:(ADNOperationBlock)operation;

+ (BOOL)performListOperation:(WryApplication *)app
                      params:(NSArray *)params
               minimumParams:(NSInteger)minimumParams
                errorMessage:(NSString *)errorMessage
                       error:(NSError **)error
                   operation:(ADNOperationBlock)operation;

+ (id <WryCommand>)commandForName:(NSString *)name;
+ (NSString *)nameForCommand:(id <WryCommand>)command;
+ (NSArray *)allCommands;
+ (id <WryFormatter>)formatterForName:(NSString *)name;
+ (NSString *)nameForFormatter:(id <WryFormatter>)formatter;
+ (NSArray *)allFormats;

@end
