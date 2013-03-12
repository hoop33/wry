//
//  WryCommand.h
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"

@protocol WryCommand <NSObject>

- (int)run:(WryApplication *)app params:(NSArray *)params;
- (void)showHelp;

@end
