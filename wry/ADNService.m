//
//  ADNService.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNService.h"
#import "ADNMappingProvider.h"
#import "ADNResponse.h"
#import "NSDictionary+JSONMapping.h"
#import "ADNFile.h"

@interface ADNService ()
- (void)performRequest:(NSURLRequest *)request;
- (NSMutableURLRequest *)getURLRequestWithPath:(NSString *)path;
- (ADNResponse *)getItems:(NSString *)path mapping:(RWJSONMapping *)mapping error:(NSError **)error;
- (ADNResponse *)getItem:(NSString *)path mapping:(RWJSONMapping *)mapping method:(NSString *)method
                   error:(NSError **)error;
- (ADNResponse *)createItem:(NSString *)path body:(NSString *)body contentHeader:(NSString *)contentHeader
                    mapping:(RWJSONMapping *)mapping
                      error:(NSError **)error;
@end

@implementation ADNService

- (id)initWithAccessToken:(NSString *)accessToken {
  self = [super init];
  if (self != nil) {
    self.accessToken = accessToken;
    self.data = [NSMutableData data];
    self.debug = NO;
  }
  return self;
}

#pragma mark - User interactions

- (ADNResponse *)getUser:(NSError **)error {
  return [self getUser:@"me" error:error];
}

- (ADNResponse *)getUser:(NSString *)username error:(NSError **)error {
  [self performRequest:[self getURLRequestWithPath:[NSString stringWithFormat:@"users/%@", username]]];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    response.object = [response.data mapToObjectWithMapping:[ADNMappingProvider userMapping]];
    return response;
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

- (ADNResponse *)getFollowers:(NSError **)error {
  return [self getFollowers:@"me" error:error];
}

- (ADNResponse *)getFollowers:(NSString *)username error:(NSError **)error {
  NSString *path = [NSString stringWithFormat:@"users/%@/followers", username];
  return [self getItems:path mapping:[ADNMappingProvider userMapping] error:error];
}

- (ADNResponse *)getFollowing:(NSError **)error {
  return [self getFollowing:@"me" error:error];
}

- (ADNResponse *)getFollowing:(NSString *)username error:(NSError **)error {
  NSString *path = [NSString stringWithFormat:@"users/%@/following", username];
  return [self getItems:path mapping:[ADNMappingProvider userMapping] error:error];
}

- (ADNResponse *)getMuted:(NSError **)error {
  return [self getMuted:@"me" error:error];
}

- (ADNResponse *)getMuted:(NSString *)username error:(NSError **)error {
  NSString *path = [NSString stringWithFormat:@"users/%@/muted", username];
  return [self getItems:path mapping:[ADNMappingProvider userMapping] error:error];
}

- (ADNResponse *)follow:(NSString *)username error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"users/%@/follow", username]
               mapping:[ADNMappingProvider userMapping] method:@"POST"
                 error:error];
}

- (ADNResponse *)unfollow:(NSString *)username error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"users/%@/follow", username]
               mapping:[ADNMappingProvider userMapping] method:@"DELETE"
                 error:error];
}

- (ADNResponse *)mute:(NSString *)username error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"users/%@/mute", username]
               mapping:[ADNMappingProvider userMapping] method:@"POST"
                 error:error];
}

- (ADNResponse *)unmute:(NSString *)username error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"users/%@/mute", username]
               mapping:[ADNMappingProvider userMapping] method:@"DELETE"
                 error:error];
}

- (ADNResponse *)block:(NSString *)username error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"users/%@/block", username]
               mapping:[ADNMappingProvider userMapping] method:@"POST"
                 error:error];
}

- (ADNResponse *)unblock:(NSString *)username error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"users/%@/block", username]
               mapping:[ADNMappingProvider userMapping] method:@"DELETE"
                 error:error];
}

- (ADNResponse *)searchUsers:(NSString *)searchString error:(NSError **)error {
  return [self getItems:[NSString stringWithFormat:@"users/search/?q=%@", searchString]
                mapping:[ADNMappingProvider userMapping]
                  error:error];
}

#pragma mark - Stream interactions

- (ADNResponse *)getUserStream:(NSError **)error {
  return [self getItems:@"posts/stream" mapping:[ADNMappingProvider postMapping] error:error];
}

- (ADNResponse *)getGlobalStream:(NSError **)error {
  return [self getItems:@"posts/stream/global" mapping:[ADNMappingProvider postMapping] error:error];
}

- (ADNResponse *)getUnifiedStream:(NSError **)error {
  return [self getItems:@"posts/stream/unified" mapping:[ADNMappingProvider postMapping] error:error];
}

- (ADNResponse *)getMentions:(NSError **)error {
  return [self getMentions:@"me" error:error];
}

- (ADNResponse *)getMentions:(NSString *)username error:(NSError **)error {
  return [self getItems:[NSString stringWithFormat:@"users/%@/mentions", username]
                mapping:[ADNMappingProvider postMapping]
                  error:error];
}

#pragma mark - Post interactions

- (ADNResponse *)getPosts:(NSError **)error {
  return [self getPosts:@"me" error:error];
}

- (ADNResponse *)getPosts:(NSString *)username error:(NSError **)error {
  return [self getItems:[NSString stringWithFormat:@"users/%@/posts", username]
                mapping:[ADNMappingProvider postMapping]
                  error:error];
}

- (ADNResponse *)createPost:(NSString *)text replyID:(NSString *)replyID error:(NSError **)error {
  return [self createItem:@"posts"
                     body:(replyID == nil ? [NSString stringWithFormat:@"text=%@", text] :
                       [NSString stringWithFormat:@"reply_to=%@&text=%@", replyID, text])
            contentHeader:nil
                  mapping:[ADNMappingProvider postMapping]
                    error:error];
}

- (ADNResponse *)showPost:(NSString *)postID error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"posts/%@", postID]
               mapping:[ADNMappingProvider postMapping] method:@"GET"
                 error:error];
}

- (ADNResponse *)repost:(NSString *)postID error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"posts/%@/repost", postID]
               mapping:[ADNMappingProvider postMapping] method:@"POST"
                 error:error];
}

- (ADNResponse *)star:(NSString *)postID error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"posts/%@/star", postID]
               mapping:[ADNMappingProvider postMapping] method:@"POST"
                 error:error];
}

- (ADNResponse *)delete:(NSString *)postID error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"posts/%@", postID]
               mapping:[ADNMappingProvider postMapping] method:@"DELETE"
                 error:error];
}

- (ADNResponse *)getReplies:(NSString *)postID error:(NSError **)error {
  return [self getItems:[NSString stringWithFormat:@"posts/%@/replies", postID]
                mapping:[ADNMappingProvider postMapping]
                  error:error];
}

- (ADNResponse *)searchPosts:(NSString *)hashtag error:(NSError **)error {
  return [self getItems:[NSString stringWithFormat:@"posts/tag/%@", hashtag]
                mapping:[ADNMappingProvider postMapping]
                  error:error];
}

#pragma mark - File interactions

- (ADNResponse *)getFile:(NSString *)fileID error:(NSError **)error {
  return [self getItem:[NSString stringWithFormat:@"files/%@", fileID] mapping:[ADNMappingProvider fileMapping]
                method:@"GET"
                 error:error];
}

- (ADNResponse *)getFiles:(NSError **)error {
  return [self getItems:@"users/me/files" mapping:[ADNMappingProvider fileMapping] error:error];
}

- (ADNResponse *)upload:(NSString *)filename content:(NSData *)data error:(NSError **)error {
  if (self.debug) {
    NSLog(@"Uploading %@", filename);
    NSLog(@"Contents: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
  }
  NSMutableURLRequest *request = [self getURLRequestWithPath:@"files"];
  request.HTTPMethod = @"POST";

  // Set headers
  NSString *boundary = @"82481319dca6"; // Arbitrary value from App.net docs
  [request addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
 forHTTPHeaderField:@"Content-Type"];

  NSMutableData *body = [NSMutableData data];

  // Attach file
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary]
                              dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"content\"; filename=\"%@\"\r\n",
                                               [filename lastPathComponent]]
                                               dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:data];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary]
                              dataUsingEncoding:NSUTF8StringEncoding]];

  // Set metadata
  [body appendData:[@"Content-Disposition: form-data; name=\"type\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"com.grailbox.wry" dataUsingEncoding:NSUTF8StringEncoding]];

  request.HTTPBody = body;

  [self performRequest:request];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    response.object = [response.data mapToObjectWithMapping:[ADNMappingProvider fileMapping]];
    return response;
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

- (ADNResponse *)download:(NSString *)fileID error:(NSError **)error {
  ADNResponse *response = [self getFile:fileID error:error];
  if (response != nil) {
    NSMutableURLRequest *request = [self getURLRequestWithPath:[NSString stringWithFormat:@"files/%@/content", fileID]];
    [self performRequest:request];
    if (self.data.length > 0) {
      ADNFile *file = (ADNFile *) response.object;
      [self.data writeToFile:file.name atomically:NO];
      return response;
    } else {
      if (error != NULL) {
        *error = self.error;
      }
      return nil;
    }
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

#pragma mark - Message interactions

- (ADNResponse *)getMessages:(NSError **)error {
  return [self getItems:@"users/me/messages"
                mapping:[ADNMappingProvider messageMapping]
                  error:error];
}

- (ADNResponse *)getMessages:(NSString *)channelID error:(NSError **)error {
  return [self getItems:[NSString stringWithFormat:@"channels/%@/messages", channelID]
                mapping:[ADNMappingProvider messageMapping]
                  error:error];
}

- (ADNResponse *)sendMessage:(NSArray *)users replyID:(NSString *)replyID channelID:(NSString *)channelID
                        text:(NSString *)text
                       error:(NSError **)error {
  if (channelID == nil || channelID.length == 0) {
    channelID = @"pm";
  }
  NSMutableDictionary *message = [NSMutableDictionary dictionary];
  // TODO add "destinations"
  [message setObject:text forKey:@"text"];
  if (replyID.length != 0) {
    [message setObject:replyID forKey:@"reply_to"];
  }
  if (users.count != 0) {
    [message setObject:users forKey:@"destinations"];
  }
  NSData *json = [NSJSONSerialization dataWithJSONObject:message options:0
                                                   error:error];
  if (json != nil) {
    NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    return [self createItem:[NSString stringWithFormat:@"channels/%@/messages", channelID]
                       body:jsonString
              contentHeader:@"application/json"
                    mapping:[ADNMappingProvider messageMapping]
                      error:error];
  }
  return nil;
}

#pragma mark - Channel interactions

- (ADNResponse *)getChannels:(NSError **)error {
  return [self getItems:@"channels"
                mapping:[ADNMappingProvider channelMapping]
                  error:error];
}

- (ADNResponse *)showChannel:(NSString *)channelID error:(NSError **)error {
  return nil;
}

#pragma mark - Helper methods

- (ADNResponse *)getItems:(NSString *)path mapping:(RWJSONMapping *)mapping error:(NSError **)error {
  NSString *countParam = [NSString stringWithFormat:@"%@count=%ld",
                                                    ([path rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&"),
                                                    self.count];
  [self performRequest:[self getURLRequestWithPath:[path stringByAppendingString:countParam]]];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dictionary in response.data) {
      [items addObject:[dictionary mapToObjectWithMapping:mapping]];
    }
    response.object = [NSArray arrayWithArray:items];
    return response;
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

- (ADNResponse *)getItem:(NSString *)path mapping:(RWJSONMapping *)mapping method:(NSString *)method
                   error:(NSError **)error {
  NSMutableURLRequest *request = [self getURLRequestWithPath:path];
  request.HTTPMethod = method;
  [self performRequest:request];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    response.object = [response.data mapToObjectWithMapping:mapping];
    return response;
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

- (ADNResponse *)createItem:(NSString *)path body:(NSString *)body contentHeader:(NSString *)contentHeader
                    mapping:(RWJSONMapping *)mapping
                      error:(NSError **)error {
  NSMutableURLRequest *request = [self getURLRequestWithPath:path];
  request.HTTPMethod = @"POST";
  request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
  if (contentHeader.length != 0) {
    [request addValue:contentHeader forHTTPHeaderField:@"Content-Type"];
  }
  [self performRequest:request];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    response.object = [response.data mapToObjectWithMapping:mapping];
    return response;
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  self.data.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  if (self.debug) {
    NSString *string = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"Before connection failed, data was: %@", string);
  }
  self.data.length = 0;
  self.error = error;
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  if (self.debug) {
    NSString *string = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", string);
  }
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)response {
  if (self.debug) {
    NSLog(@"Sending to %@", request.URL);
  }
  return request;
}

#pragma mark - Network methods

- (void)performRequest:(NSURLRequest *)request {
  if (self.debug) {
    NSLog(@"URL: %@", request.URL);
    NSLog(@"Headers:");
    for (NSString *key in request.allHTTPHeaderFields.allKeys) {
      NSLog(@"%@ : %@", key, [request.allHTTPHeaderFields valueForKey:key]);
    }
    NSLog(@"Body: %@", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    NSLog(@"Method: %@", request.HTTPMethod);
  }
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                delegate:self
                                                        startImmediately:NO];
  [connection start];
  CFRunLoopRun();
}

- (NSMutableURLRequest *)getURLRequestWithPath:(NSString *)path {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/%@", path]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setValue:[NSString stringWithFormat:@"Bearer %@", self.accessToken] forHTTPHeaderField:@"Authorization"];
  if (self.pretty) {
    [request setValue:@"1" forHTTPHeaderField:@"X-ADN-Pretty-JSON"];
  }
  return request;
}

@end
