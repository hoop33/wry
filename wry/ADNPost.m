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
#import "ADNLink.h"
#import "ADNHashtag.h"

@implementation ADNPost

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:(self.user == nil ? @"[RETIRED USER]" : [self.user shortDescription])];
  [str appendFormat:@"\n%@", (self.text == nil ? @"[REDACTED]" : self.text)];
  [str appendFormat:@"\nID: %ld -- %@", self.postID, self.createdAt];
  for (ADNLink *link in self.links) {
    [str appendFormat:@"\n%@", [link description]];
  }
  for (ADNHashtag *hashtag in self.hashtags) {
    [str appendFormat:@"\n%@", [hashtag description]];
  }
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendString:@"\n----------"];
  return str;
}

@end
