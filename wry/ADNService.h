//
//  ADNService.h
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADNUser;
@class WryApplication;
@class ADNPost;

@interface ADNService : NSObject <NSURLConnectionDataDelegate>

@property(nonatomic, strong) WryApplication *app;
@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, strong) NSError *error;

- (id)initWithApplication:(WryApplication *)app;
- (ADNUser *)getUser:(NSError **)error;
- (ADNUser *)getUser:(NSString *)username error:(NSError **)error;
- (NSArray *)getUserStream:(NSError **)error;
- (NSArray *)getGlobalStream:(NSError **)error;
- (NSArray *)getUnifiedStream:(NSError **)error;
- (ADNPost *)createPost:(NSString *)text error:(NSError **)error;

@end
