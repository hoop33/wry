//
//  ADNPost.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNPost.h"
#import "ADNUser.h"
#import "ADNAnnotation.h"

@implementation ADNPost

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:(self.user == nil ? @"[RETIRED USER]" : [self.user shortDescription])];
  [str appendFormat:@"\n%@", (self.text == nil ? @"[REDACTED]" : self.text)];
  [str appendFormat:@"\nID: %ld -- %@", self.postID, self.createdAt];
  [str appendString:@"\n----------"];
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  return str;
}

@end
