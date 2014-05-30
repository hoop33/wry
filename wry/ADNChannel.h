//
//  ADNChannel.h
//  wry
//
//  Created by Rob Warner on 5/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNObject.h"

@class ADNUser;
@class ADNAccessControlList;

@interface ADNChannel : ADNObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) ADNUser *owner;
@property (nonatomic, strong) ADNAccessControlList *readers;
@property (nonatomic, strong) ADNAccessControlList *writers;
@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, assign) BOOL muted;
@property (nonatomic, assign) BOOL subscribed;
@property (nonatomic, assign) BOOL edit;

+ (NSString *)nameForType:(NSString *)type;

@end
