//
//  ADNOperation.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNOperation.h"

@interface ADNOperation ()
- (void)stopRunLoop;
@end

@implementation ADNOperation

- (id)initWithDelegate:(id <ADNOperationDelegate>)delegate request:(NSURLRequest *)request {
  self = [super init];
  if (self != nil) {
    NSLog(@"It's initted");
    self.delegate = delegate;
    self.request = request;
    self.data = [NSMutableData data];
    self.port = [NSPort port];
  }
  return self;
}

- (void)main {
  @autoreleasepool {
    NSLog(@"Going for it");
    NSURLConnection *connection = [[NSURLConnection alloc]
                                                    initWithRequest:self.request delegate:self startImmediately:NO];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:self.port forMode:NSDefaultRunLoopMode];
    [connection scheduleInRunLoop:runLoop forMode:NSDefaultRunLoopMode];
    [connection start];
    [runLoop run];
  }
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  NSLog(@"Hello");
  self.data.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  NSLog(@"Error!!!");
  [self stopRunLoop];
  if (self.delegate != nil) {
    [self.delegate operationDidFinishWithError:error];
  }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSLog(@"Finished");
  [self stopRunLoop];
  if (self.delegate != nil) {
    [self.delegate operationDidFinishWithData:self.data];
  }
}

#pragma mark - Private methods

- (void)stopRunLoop {
  NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
  [runLoop removePort:self.port forMode:NSDefaultRunLoopMode];
}

@end
