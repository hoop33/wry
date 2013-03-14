//
//  RWJSONMapper.h
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWJSONMapping;

@interface RWJSONMapper : NSObject

+ (id)mapObjectFromData:(NSData *)data mapping:(RWJSONMapping *)mapping;

@end
