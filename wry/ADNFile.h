//
//  ADNFile.h
//  wry
//
//  Created by Rob Warner on 04/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@interface ADNFile : NSObject

@property(nonatomic, assign) NSInteger fileID;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger totalSize;
@property(nonatomic, copy) NSString *sha1;
@property(nonatomic, strong) NSDate *createdAt;
@property(nonatomic, strong) NSArray *annotations;

@end
