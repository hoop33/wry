//
//  ADNOperation.h
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

@class ADNService;

@protocol ADNOperationDelegate <NSObject>
- (void)operationDidFinishWithData:(NSData *)data;
- (void)operationDidFinishWithError:(NSError *)error;
@end

@interface ADNOperation : NSOperation <NSURLConnectionDataDelegate>

@property(nonatomic, weak) id <ADNOperationDelegate> delegate;
@property(nonatomic, strong) NSURLRequest *request;
@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, strong) NSPort *port;

- (id)initWithDelegate:(id <ADNOperationDelegate>)delegate request:(NSURLRequest *)request;

@end
