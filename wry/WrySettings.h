//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SettingsDefaultUser;
extern NSString * const SettingsEditor;
extern NSString * const SettingsTextColor;

@interface WrySettings : NSObject

- (NSString *)getString:(NSString *)key;
- (void)set:(NSString *)key value:(NSObject *)value;

@end
