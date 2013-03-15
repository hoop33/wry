//
//  ADNResponse.m
//  wry
//
//  Created by Rob Warner on 3/15/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNResponse.h"

@implementation ADNResponse

- (id)initWithData:(NSData *)data {
  self = [super init];
  if (self != nil) {
    // TODO do something with error
    NSError *error;
    NSDictionary *wrapper = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    self.meta = [wrapper objectForKey:@"meta"];
    self.data = [wrapper objectForKey:@"data"];
  }
  return self;
}

@end
