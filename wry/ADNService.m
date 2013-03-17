//
//  ADNService.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNService.h"
#import "ADNUser.h"
#import "WryApplication.h"
#import "NSDictionary+JSONMapping.h"
#import "ADNMappingProvider.h"
#import "ADNResponse.h"
#import "ADNPost.h"

@interface ADNService ()
- (void)performRequest:(NSURLRequest *)request;
- (NSMutableURLRequest *)getURLRequestWithPath:(NSString *)path;
- (NSArray *)getStream:(NSString *)path;
@end

@implementation ADNService

- (id)initWithApplication:(WryApplication *)app {
  self = [super init];
  if (self != nil) {
    self.app = app;
    self.data = [NSMutableData data];
  }
  return self;
}

- (ADNUser *)getUser {
  return [self getUser:@"me"];
}

- (ADNUser *)getUser:(NSString *)username {
  [self performRequest:[self getURLRequestWithPath:[NSString stringWithFormat:@"users/%@", username]]];
  ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
  ADNUser *user = (ADNUser *) [response.data mapToObjectWithMapping:[ADNMappingProvider userMapping]];
  return user;
}

- (NSArray *)getUserStream {
  return [self getStream:@"posts/stream"];
}

- (NSArray *)getGlobalStream {
  return [self getStream:@"posts/stream/global"];
}

- (NSArray *)getUnifiedStream {
  return [self getStream:@"posts/stream/unified"];
}

- (NSArray *)getStream:(NSString *)path {
  [self performRequest:[self getURLRequestWithPath:path]];
  ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
  NSMutableArray *posts = [NSMutableArray array];
  for (NSDictionary *dictionary in response.data) {
    ADNPost *post = (ADNPost *)[dictionary mapToObjectWithMapping:[ADNMappingProvider postMapping]];
    [posts addObject:post];
  }
  return [NSArray arrayWithArray:posts];
}

- (ADNPost *)createPost:(NSString *)text {
  NSMutableURLRequest *request = [self getURLRequestWithPath:@"posts"];
  request.HTTPMethod = @"POST";
  request.HTTPBody = [[NSString stringWithFormat:@"text=%@", text] dataUsingEncoding:NSUTF8StringEncoding];
  [self performRequest:request];
  ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
  ADNPost *post = (ADNPost *)[response.data mapToObjectWithMapping:[ADNMappingProvider postMapping]];
  return post;
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  self.data.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  // TODO ?? Delete data and capture error
  [self.app println:[error localizedDescription]];
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark - Private methods

- (void)performRequest:(NSURLRequest *)request {
  [[NSURLConnection alloc] initWithRequest:request
                                  delegate:self
                          startImmediately:YES];
  CFRunLoopRun();
  // TODO print error here?
}

- (NSMutableURLRequest *)getURLRequestWithPath:(NSString *)path {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/%@", path]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setValue:[NSString stringWithFormat:@"Bearer %@", self.app.accessToken] forHTTPHeaderField:@"Authorization"];
  return request;
}

@end
