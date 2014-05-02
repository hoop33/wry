//
//  WryApplication.h
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@protocol WryCommand;
@protocol WryFormatter;
@class WrySettings;

@interface WryApplication : NSObject

@property(nonatomic, assign, readonly) BOOL interactiveIn;
@property(nonatomic, assign, readonly) BOOL interactiveOut;
@property(nonatomic, strong) WrySettings *settings;
@property(nonatomic, copy) NSString *appName;
@property(nonatomic, copy) NSString *commandName;
@property(nonatomic, strong) NSArray *params;
@property(nonatomic, copy) NSString *accessToken;
@property(nonatomic, strong) id <WryFormatter> formatter;

+ (WryApplication *)application;
+ (int)maximumPostLength;

- (BOOL)parseCommandLine:(NSArray *)parameters;
- (int)run;
- (void)print:(NSString *)output;
- (void)println:(NSObject *)output;
- (void)openURL:(NSString *)urlString;
- (NSString *)getInput;
- (NSString *)version;
- (NSString *)errorDomain;

@end
