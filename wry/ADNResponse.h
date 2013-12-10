//
//  ADNResponse.h
//  wry
//
//  Created by Rob Warner on 3/15/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNObject.h"

@class ADNJSONMapping;

@interface ADNResponse : ADNObject

@property(nonatomic, strong) NSDictionary *meta;
@property(nonatomic, strong) id data;
@property(nonatomic, copy) NSString *json;
@property(nonatomic, strong) id object;

- (id)initWithData:(NSData *)data;

@end
