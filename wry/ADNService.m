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
- (NSURLRequest *)getURLRequestWithPath:(NSString *)path;
@end

@implementation ADNService

- (id)initWithApplication:(WryApplication *)app {
  self = [super init];
  if (self != nil) {
    self.app = app;
  }
  return self;
}

- (ADNUser *)getUser {
  return [self getUser:nil];
}

- (ADNUser *)getUser:(NSString *)username {
  ADNUser *user = nil;
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
  [self.app println:[error localizedDescription]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

}

#pragma mark - Private methods

- (NSURLRequest *)getURLRequestWithPath:(NSString *)path {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha-api.app.net/%@", path]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setValue:[NSString stringWithFormat:@"Bearer %@", self.app.accessToken] forHTTPHeaderField:@"Authorization"];
  return request;
}

- (void)runRequest:(NSURLRequest *)request {
  NSURLConnection *connection = [[NSURLConnection alloc]
    initWithRequest:request delegate:self startImmediately:NO];
  if (connection != nil) {
    self.data = [NSMutableData data];

  }

}

@end
