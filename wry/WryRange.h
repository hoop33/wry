//
//  WryRange.h
//  wry
//
//  Created by Rob Warner on 8/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WryRange : NSObject

@property (nonatomic) int from;
@property (nonatomic) int to;

- (id)initWithRange:(NSRange)range;
- (id)initWithFrom:(int)from to:(int)to;

@end
