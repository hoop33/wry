//
//  WryCommand.h
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"

@protocol WryCommand <NSObject>

- (void)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error;
- (NSString *)help;

@end
