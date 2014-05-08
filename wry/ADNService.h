//
//  ADNService.h
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADNResponse;

@interface ADNService : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *beforeId;
@property (nonatomic, copy) NSString *sinceId;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) BOOL debug;
@property (nonatomic, assign) BOOL pretty;
@property (nonatomic, assign) BOOL reverse;
@property (nonatomic, assign) BOOL annotations;

- (id)initWithAccessToken:(NSString *)accessToken;

// Users
- (ADNResponse *)getUser:(NSError **)error;
- (ADNResponse *)getUser:(NSString *)username error:(NSError **)error;
- (ADNResponse *)getFollowers:(NSError **)error;
- (ADNResponse *)getFollowers:(NSString *)username error:(NSError **)error;
- (ADNResponse *)getFollowing:(NSError **)error;
- (ADNResponse *)getFollowing:(NSString *)username error:(NSError **)error;
- (ADNResponse *)getMuted:(NSError **)error;
- (ADNResponse *)getMuted:(NSString *)username error:(NSError **)error;
- (ADNResponse *)follow:(NSString *)username error:(NSError **)error;
- (ADNResponse *)unfollow:(NSString *)username error:(NSError **)error;
- (ADNResponse *)mute:(NSString *)username error:(NSError **)error;
- (ADNResponse *)unmute:(NSString *)username error:(NSError **)error;
- (ADNResponse *)block:(NSString *)username error:(NSError **)error;
- (ADNResponse *)unblock:(NSString *)username error:(NSError **)error;
- (ADNResponse *)searchUsers:(NSString *)searchString error:(NSError **)error;

// Streams
- (ADNResponse *)getUserStream:(NSError **)error;
- (ADNResponse *)getGlobalStream:(NSError **)error;
- (ADNResponse *)getUnifiedStream:(NSError **)error;
- (ADNResponse *)getMentions:(NSError **)error;
- (ADNResponse *)getMentions:(NSString *)username error:(NSError **)error;

// Posts
- (ADNResponse *)getPosts:(NSError **)error;
- (ADNResponse *)getPosts:(NSString *)username error:(NSError **)error;
- (ADNResponse *)createPost:(NSString *)text replyID:(NSString *)replyID error:(NSError **)error;
- (ADNResponse *)showPost:(NSString *)postID error:(NSError **)error;
- (ADNResponse *)searchPosts:(NSDictionary *)criteria error:(NSError **)error;
- (ADNResponse *)searchPostsForHashtag:(NSString *)hashtag error:(NSError **)error;
- (ADNResponse *)getReplies:(NSString *)postID error:(NSError **)error;
- (ADNResponse *)repost:(NSString *)postID error:(NSError **)error;
- (ADNResponse *)star:(NSString *)postID error:(NSError **)error;
- (ADNResponse *)delete:(NSString *)postID error:(NSError **)error;

// Files
- (ADNResponse *)upload:(NSString *)filename content:(NSData *)data error:(NSError **)error;
- (ADNResponse *)download:(NSString *)fileID error:(NSError **)error;
- (ADNResponse *)getFiles:(NSError **)error;
- (ADNResponse *)getFile:(NSString *)fileID error:(NSError **)error;
- (ADNResponse *)updateFile:(NSString *)fileID name:(NSString *)name makePublic:(NSNumber *)makePublic error:(NSError **)error;
- (ADNResponse *)deleteFile:(NSString *)fileID error:(NSError **)error;

// Messages
- (ADNResponse *)getMessages:(NSError **)error;
- (ADNResponse *)getMessages:(NSString *)channelID error:(NSError **)error;
- (ADNResponse *)sendMessage:(NSArray *)users replyID:(NSString *)replyID channelID:(NSString *)channelID
                        text:(NSString *)text error:(NSError **)error;
- (ADNResponse *)getMessage:(NSString *)messageID channelID:(NSString *)channelID error:(NSError **)error;

// Channels
- (ADNResponse *)getChannels:(NSError **)error;
- (ADNResponse *)getChannel:(NSString *)channelID error:(NSError **)error;

@end
