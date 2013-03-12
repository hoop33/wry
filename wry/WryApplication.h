//
//  WryApplication.h
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@interface WryApplication : NSObject

@property(nonatomic, copy) NSString *appName;
@property(nonatomic, copy) NSString *command;
@property(nonatomic, strong) NSArray *params;
@property(nonatomic) BOOL quiet;
@property(nonatomic) int count;

- (int)run;
- (void)print:(NSString *)output;
- (void)println:(NSString *)output;
- (void)openURL:(NSString *)urlString;
- (NSString *)getInput;
- (NSString *)version;
- (NSString *)helpLine;

@end
