//
//  ADNService.h
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADNOperation.h"

@class ADNUser;
@class WryApplication;

@interface ADNService : NSObject <ADNOperationDelegate>

@property(nonatomic, strong) WryApplication *app;
@property(nonatomic, strong) NSOperationQueue *queue;

- (id)initWithApplication:(WryApplication *)app;
- (ADNUser *)getUser;
- (ADNUser *)getUser:(NSString *)username;

@end
