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
#import "RWJSONMapper.h"
#import "ADNMappingProvider.h"

@interface ADNService ()
- (NSMutableURLRequest *)getURLRequestWithPath:(NSString *)path;
@end

@implementation ADNService

- (id)initWithApplication:(WryApplication *)app {
  self = [super init];
  if (self != nil) {
    self.app = app;
    self.queue = [[NSOperationQueue alloc] init];
  }
  return self;
}

- (ADNUser *)getUser {
  return [self getUser:nil];
}

- (ADNUser *)getUser:(NSString *)username {
  ADNUser *user = nil;
  NSString *path = @"stream/0/users";
  if (username != nil) {
    path = [path stringByAppendingFormat:@"/%@", username];
  }
  NSMutableURLRequest *request = [self getURLRequestWithPath:path];
  ADNOperation *operation = [[ADNOperation alloc]
                                           initWithDelegate:self request:request];
  [self.queue addOperations:@[operation] waitUntilFinished:YES];
//  [self.queue addOperation:operation];
  return user;
}

#pragma mark - ADNOperationDelegate methods

- (void)operationDidFinishWithData:(NSData *)data {
  // TODO do something with the data
  NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  [self.app println:string];
  [RWJSONMapper mapObjectFromData:data mapping:[ADNMappingProvider userMapping]];
}

- (void)operationDidFinishWithError:(NSError *)error {
  [self.app println:[error localizedDescription]];
}

#pragma mark - Private methods

- (NSMutableURLRequest *)getURLRequestWithPath:(NSString *)path {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha-api.app.net/%@", path]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setValue:[NSString stringWithFormat:@"Bearer %@", self.app.accessToken] forHTTPHeaderField:@"Authorization"];
  return request;
}

@end
