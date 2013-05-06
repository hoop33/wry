//
//  ADNMessage.h
//  wry
//
//  Created by Rob Warner on 05/06/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@class ADNUser;

@interface ADNMessage : NSObject

@property(nonatomic, assign) NSInteger messageID;
@property(nonatomic, assign) NSInteger channelID;
@property(nonatomic, assign) NSInteger rootMessageID;
@property(nonatomic, assign) NSInteger replyToID;
@property(nonatomic, strong) ADNUser *user;
@property(nonatomic, strong) NSDate *createdAt;
@property(nonatomic, copy) NSString *text;

@end
