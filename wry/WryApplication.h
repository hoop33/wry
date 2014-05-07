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
@class WryCommandLine;

@interface WryApplication : NSObject

@property (nonatomic, assign, readonly) BOOL interactiveIn;
@property (nonatomic, assign, readonly) BOOL interactiveOut;
@property (nonatomic, strong) WrySettings *settings;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *accessToken;

+ (WryApplication *)application;
+ (int)maximumPostLength;

- (void)print:(NSString *)output;
- (void)println:(NSObject *)output;
- (void)openURL:(NSString *)urlString;
- (NSString *)getInput;
- (NSString *)version;
- (NSString *)errorDomain;
- (NSString *)defaultUser;

@end
