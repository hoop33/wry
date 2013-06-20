//
//  NSDictionary+JSONMapping.h
//  wry
//
//  Created by Rob Warner on 3/15/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADNJSONMapping;

@interface NSDictionary (JSONMapping)

- (NSObject *)mapToObjectWithMapping:(ADNJSONMapping *)mapping;

@end
