//
//  ADNChannel.m
//  wry
//
//  Created by Rob Warner on 5/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNChannel.h"
#import "ADNUser.h"
#import "ADNAnnotation.h"

@implementation ADNChannel

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendFormat:@"Type: %@", self.type];
  [str appendFormat:@"\nOwner: %@", (self.owner == nil ? @"[RETIRED OWNER]" : [self.owner shortDescription])];
  [str appendFormat:@"\nID: %ld", self.channelID];
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendString:@"\n----------"];
  return str;
}

@end
