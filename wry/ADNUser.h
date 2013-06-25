//
//  ADNUser.h
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNObject.h"

@class ADNUserDescription;

@interface ADNUser : ADNObject

@property(nonatomic, assign) NSInteger userID;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) ADNUserDescription *userDescription;
@property(nonatomic, assign) BOOL followsYou;
@property(nonatomic, assign) BOOL youFollow;
@property(nonatomic, strong) NSArray *annotations;

- (NSString *)shortDescription;
- (NSString *)colorShortDescription;

@end
