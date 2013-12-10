//
//  WryUtils.h
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryCommand.h"
#import "WryFormatter.h"
#import "WrySetting.h"

@class ADNUser;
@class ADNService;
@class WryApplication;

typedef id (^ADNOperationBlock)(ADNService *service);
typedef void (^ADNOutputOperationBlock)(NSObject *response);

@interface WryUtils : NSObject

+ (BOOL)getADNResponseForOperation:(NSString *)accessToken
                            params:(NSArray *)params
                     minimumParams:(NSInteger)minimumParams
                      errorMessage:(NSString *)errorMessage
                             error:(NSError **)error
                          response:(ADNResponse **)adnResponse
                         operation:(ADNOperationBlock)operation;
+ (BOOL)performObjectOperation:(NSArray *)params
                 minimumParams:(NSInteger)minimumParams
                  errorMessage:(NSString *)errorMessage
                         error:(NSError **)error
                     operation:(ADNOperationBlock)operation;
+ (BOOL)performListOperation:(NSArray *)params
               minimumParams:(NSInteger)minimumParams
                errorMessage:(NSString *)errorMessage
                       error:(NSError **)error
                   operation:(ADNOperationBlock)operation;
+ (id <WryCommand>)commandForName:(NSString *)name;
+ (NSString *)nameForCommand:(id <WryCommand>)command;
+ (NSArray *)allCommands;
+ (id <WryFormatter>)formatterForName:(NSString *)name;
+ (NSString *)nameForFormatter:(id <WryFormatter>)formatter;
+ (NSArray *)allFormatters;
+ (id <WrySetting>)settingForName:(NSString *)name;
+ (id <WrySetting>)settingForShortFlag:(NSString *)shortFlag;
+ (NSString *)nameForSettingForClass:(Class)cls;
+ (NSString *)nameForSetting:(id <WrySetting>)setting;
+ (NSArray *)allSettings;

@end
