//
//  ADNLink.m
//  wry
//
//  Created by Rob Warner on 6/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNLink.h"

@implementation ADNLink

- (NSString *)description {
  if([self.text isEqualToString:self.url]){
    return [NSString stringWithFormat:@"[%@]", self.text];
  } else {
    return [NSString stringWithFormat:@"[%@](%@)", self.text, self.url];
  }
}

- (NSDictionary *)asDictionary {
  // Note that we omit text, as per ADN guidelines
  return @{
    @"url" : self.url,
    @"pos" : [NSNumber numberWithLong:self.position],
    @"len" : [NSNumber numberWithLong:self.length]
  };
}

@end
