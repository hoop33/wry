//
//  ADNResponse.h
//  wry
//
//  Created by Rob Warner on 3/15/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADNResponse : NSObject

@property(nonatomic, strong) NSDictionary *meta;
@property(nonatomic, strong) id data;

- (id)initWithData:(NSData *)data;

@end
