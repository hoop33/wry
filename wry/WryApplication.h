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
@property(nonatomic, copy) NSString *format;
@property(nonatomic, copy) NSString *user;
@property(nonatomic, assign) BOOL debug;
@property(nonatomic, assign) BOOL quiet;
@property(nonatomic, assign) BOOL pretty;
@property(nonatomic, assign) BOOL reverse;
@property(nonatomic, assign) BOOL annotations;
@property(nonatomic, assign) int count;

+ (WryApplication *)application;
+ (int)maximumPostLength;

- (int)run;
- (void)print:(NSString *)output;
- (void)println:(NSObject *)output;
- (void)openURL:(NSString *)urlString;
- (NSString *)getInput;
- (NSString *)version;
- (NSString *)errorDomain;

@end
