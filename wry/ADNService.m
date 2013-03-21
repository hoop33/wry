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
- (NSArray *)getItems:(NSString *)path mapping:(RWJSONMapping *)mapping error:(NSError **)error;
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

- (ADNUser *)getUser:(NSError **)error {
  return [self getUser:@"me" error:error];
}

- (ADNUser *)getUser:(NSString *)username error:(NSError **)error {
  [self performRequest:[self getURLRequestWithPath:[NSString stringWithFormat:@"users/%@", username]]];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    return (ADNUser *) [response.data mapToObjectWithMapping:[ADNMappingProvider userMapping]];
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

- (NSArray *)getFollowers:(NSError **)error {
  return [self getFollowers:@"me" error:error];
}

- (NSArray *)getFollowers:(NSString *)username error:(NSError **)error {
  NSString *path = [NSString stringWithFormat:@"users/%@/followers", username];
  return [self getItems:path mapping:[ADNMappingProvider userMapping] error:error];
}

- (NSArray *)getUserStream:(NSError **)error {
  return [self getItems:@"posts/stream" mapping:[ADNMappingProvider postMapping] error:error];
}

- (NSArray *)getGlobalStream:(NSError **)error {
  return [self getItems:@"posts/stream/global" mapping:[ADNMappingProvider postMapping] error:error];
}

- (NSArray *)getUnifiedStream:(NSError **)error {
  return [self getItems:@"posts/stream/unified" mapping:[ADNMappingProvider postMapping] error:error];
}

- (NSArray *)getItems:(NSString *)path mapping:(RWJSONMapping *)mapping error:(NSError **)error {
  [self performRequest:[self getURLRequestWithPath:path]];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dictionary in response.data) {
      [items addObject:[dictionary mapToObjectWithMapping:mapping]];
    }
    return [NSArray arrayWithArray:items];
  } else {
    if (error != NULL) {
      *error = self.error;
    }
    return nil;
  }
}

- (ADNPost *)createPost:(NSString *)text error:(NSError **)error {
  NSMutableURLRequest *request = [self getURLRequestWithPath:@"posts"];
  request.HTTPMethod = @"POST";
  request.HTTPBody = [[NSString stringWithFormat:@"text=%@", text] dataUsingEncoding:NSUTF8StringEncoding];
  [self performRequest:request];
  if (self.data.length > 0) {
    ADNResponse *response = [[ADNResponse alloc] initWithData:self.data];
    ADNPost *post = (ADNPost *) [response.data mapToObjectWithMapping:[ADNMappingProvider postMapping]];
    return post;
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
  self.data.length = 0;
  self.error = error;
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark - Private methods

- (void)performRequest:(NSURLRequest *)request {
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                delegate:self
                                                        startImmediately:NO];
  [connection start];
  CFRunLoopRun();
}

- (NSMutableURLRequest *)getURLRequestWithPath:(NSString *)path {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/%@", path]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setValue:[NSString stringWithFormat:@"Bearer %@", self.app.accessToken] forHTTPHeaderField:@"Authorization"];
  return request;
}

@end
