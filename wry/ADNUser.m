//
//  ADNUser.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNUser.h"
#import "ADNUserDescription.h"
#import "ADNAnnotation.h"

@implementation ADNUser

- (NSString *)shortDescription {
  NSString *relationship;
  if (self.youFollow && self.followsYou) relationship = @" <--> You";
  else if (self.youFollow) relationship = @" <-- You";
  else if (self.followsYou) relationship = @" --> You";
  else relationship = @"";  /* no relationship */

  NSString *shortDescription = [NSString stringWithFormat:@"%@ (@%@) (%ld)%@",
                                self.name, self.username, (long) self.userID,
                                relationship];
  return shortDescription;
}

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:[self shortDescription]];
  if (self.userDescription != nil) {
    [str appendFormat:@"\n%@", [self.userDescription description]];
  }
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendString:@"\n----------"];
  return str;
}

@end
