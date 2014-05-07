//
//  ADNJSONMapping.h
//  wry
//
//  Created by Rob Warner on 3/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@interface ADNJSONMapping : NSObject

@property (nonatomic, strong) Class cls;
@property (nonatomic, strong) NSArray *entries;

- (id)initWithClass:(Class)cls;

@end
