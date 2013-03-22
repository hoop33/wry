//
//  WryCommand.h
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"

@protocol WryCommand <NSObject>

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error;
- (NSString *)usage;
- (NSString *)help;
- (NSString *)summary;

@end
