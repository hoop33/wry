//
//  WrySettings.h
//  wry
//
//  Created by Rob Warner on 4/30/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WrySettings : NSObject

@property(nonatomic, copy) NSString *defaultUser;
@property(nonatomic, copy) NSString *editor;

- (void)save;

@end
