//
//  ADNAccessControlList.h
//  wry
//
//  Created by Rob Warner on 5/14/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNObject.h"

@interface ADNAccessControlList : ADNObject

@property(nonatomic, assign) BOOL anyUser;
@property(nonatomic, assign) BOOL immutable;
@property(nonatomic, assign) BOOL public;
@property(nonatomic, assign) BOOL you;
@property(nonatomic, strong) NSArray *userIDs;

@end
