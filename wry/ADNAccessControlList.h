//
//  ADNAccessControlList.h
//  wry
//
//  Created by Rob Warner on 5/14/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@interface ADNAccessControlList : NSObject

@property(nonatomic, assign) BOOL anyUser;
@property(nonatomic, assign) BOOL immutable;
@property(nonatomic, assign) BOOL public;
@property(nonatomic, assign) BOOL you;
@property(nonatomic, strong) NSArray *userIDs;

@end
