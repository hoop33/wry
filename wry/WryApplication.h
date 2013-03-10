//
//  WryApplication.h
//  wry
//
//  Created by Rob Warner on 3/9/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WryApplication : NSObject

@property (nonatomic, copy) NSString *command;
@property (nonatomic, strong) NSArray *params;

- (int)run;

@end
