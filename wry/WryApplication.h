//
//  WryApplication.h
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@protocol WryCommand;

@interface WryApplication : NSObject

@property(nonatomic, copy) NSString *appName;
@property(nonatomic, copy) NSString *commandName;
@property(nonatomic, strong) NSArray *params;
@property(nonatomic, copy) NSString *accessToken;
@property(nonatomic) BOOL debug;
@property(nonatomic) BOOL quiet;
@property(nonatomic) int count;

- (int)run;
- (void)print:(NSString *)output;
- (void)println:(NSObject *)output;
- (void)openURL:(NSString *)urlString;
- (NSString *)getInput;
- (NSString *)version;
- (NSString *)errorDomain;
- (id <WryCommand>)commandForName:(NSString *)name;
- (NSString *)nameForCommand:(id <WryCommand>)command;
- (NSArray *)allCommands;
@end
