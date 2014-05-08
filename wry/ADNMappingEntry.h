//
//  ADNMappingEntry.h
//  wry
//
//  Created by Rob Warner on 6/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADNJSONMapping;

@interface ADNMappingEntry : NSObject

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, strong) ADNJSONMapping *mapping;

+ (ADNMappingEntry *)mappingEntry:(NSString *)from to:(NSString *)to mapping:(ADNJSONMapping *)mapping;

@end
