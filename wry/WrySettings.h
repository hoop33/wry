//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WrySettings : NSObject

+ (NSString *)defaultUser;
+ (void)setDefaultUser:(NSString *)defaultUser;
+ (NSString *)editor;
+ (void)setEditor:(NSString *)editor;

@end
