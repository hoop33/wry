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

@interface ADNService ()
- (void)performRequest:(NSString *)path;
- (NSURLRequest *)getURLRequestWithPath:(NSString *)path;
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
  ADNUser *user = nil;
  [self performRequest:[NSString stringWithFormat:@"users/%@", username]];
  // TODO create user from self.data
  return user;
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  self.data.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  // TODO ??
  [self.app println:[error localizedDescription]];
  CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSString *string = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
  [self.app println:string];
  CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark - Private methods

- (void)performRequest:(NSString *)path {
  [[NSURLConnection alloc] initWithRequest:[self getURLRequestWithPath:path]
                                  delegate:self
                          startImmediately:YES];
  CFRunLoopRun();
}

- (NSURLRequest *)getURLRequestWithPath:(NSString *)path {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/%@", path]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setValue:[NSString stringWithFormat:@"Bearer %@", self.app.accessToken] forHTTPHeaderField:@"Authorization"];
  return request;
}

@end
