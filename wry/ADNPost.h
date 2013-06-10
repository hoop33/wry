//
//  ADNPost.h
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@class ADNUser;

@interface ADNPost : NSObject

@property(nonatomic, assign) NSInteger postID;
@property(nonatomic, strong) ADNUser *user;
@property(nonatomic, strong) NSDate *createdAt;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) NSArray *annotations;
@property(nonatomic, strong) NSArray *hashtags;
@property(nonatomic, strong) NSArray *links;

@end
