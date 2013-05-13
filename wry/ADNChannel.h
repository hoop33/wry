//
//  ADNChannel.h
//  wry
//
//  Created by Rob Warner on 5/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@class ADNUser;

@interface ADNChannel : NSObject

@property(nonatomic, assign) NSInteger channelID;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, strong) ADNUser *owner;
@property(nonatomic, assign) BOOL muted;
@property(nonatomic, assign) BOOL subscribed;
@property(nonatomic, assign) BOOL edit;

@end
