//
//  WryComposer.h
//  wry
//
//  Created by Rob Warner on 6/14/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WryApplication;
@class ADNPost;

@interface WryComposer : NSObject

@property (nonatomic, strong) ADNPost *post;

+ (NSString *)help;
- (NSString *)compose;

@end
