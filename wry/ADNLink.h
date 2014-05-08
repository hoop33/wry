//
//  ADNLink.h
//  wry
//
//  Created by Rob Warner on 6/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNObject.h"

@interface ADNLink : ADNObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSUInteger position;
@property (nonatomic, assign) NSUInteger length;

- (NSDictionary *)asDictionary; // Used for JSON serialization

@end
