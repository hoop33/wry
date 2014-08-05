//
//  ADNResponse.m
//  wry
//
//  Created by Rob Warner on 3/15/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNResponse.h"
#import "NSDictionary+JSONMapping.h"
#import "ADNJSONMapping.h"

@implementation ADNResponse

- (id)initWithData:(NSData *)data mapping:(ADNJSONMapping *)mapping reverse:(BOOL)reverse error:(NSError **)error {
  self = [super init];
  if (self != nil) {
    if (data != nil) {
      NSDictionary *wrapper = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
      _meta = [wrapper objectForKey:@"meta"];
      _data = [wrapper objectForKey:@"data"];
      _json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      [self parseData:mapping reverse:reverse];
    }
  }
  return self;
}

- (void)parseData:(ADNJSONMapping *)mapping reverse:(BOOL)reverse {
  if ([self.data isKindOfClass:[NSArray class]]) {
    NSArray *results = (NSArray *) self.data;
    NSEnumerator *enumerator = reverse ? [results reverseObjectEnumerator] : [results objectEnumerator];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:results.count];
    for (NSDictionary *dictionary in enumerator) {
      [items addObject:[dictionary mapToObjectWithMapping:mapping]];
    }
    self.object = [NSArray arrayWithArray:items];
  } else {
    self.object = [self.data mapToObjectWithMapping:mapping];
  }
}

@end
