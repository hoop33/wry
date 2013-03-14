//
//  ADNUser.h
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@interface ADNUser : NSObject

@property(nonatomic, assign) NSInteger userID;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) BOOL followsYou;
@property(nonatomic, assign) BOOL youFollow;

@end
