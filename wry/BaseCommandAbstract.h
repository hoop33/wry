//
//  BaseCommandAbstract.h
//  wry
//
//  Created by Rob Warner on 9/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryCommand.h"

@interface BaseCommandAbstract : NSObject <WryCommand>

@property (nonatomic, strong) WrySettings *settings;

@end
