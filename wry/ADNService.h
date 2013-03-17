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

@interface ADNService : NSObject <NSURLConnectionDataDelegate>

@property(nonatomic, strong) WryApplication *app;
@property(nonatomic, strong) NSMutableData *data;

- (id)initWithApplication:(WryApplication *)app;
- (ADNUser *)getUser;
- (ADNUser *)getUser:(NSString *)username;
- (NSArray *)getUserStream;
- (NSArray *)getGlobalStream;
- (NSArray *)getUnifiedStream;

@end
