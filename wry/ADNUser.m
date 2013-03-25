//
//  ADNUser.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNUser.h"
#import "ADNUserDescription.h"

@implementation ADNUser

- (NSString *)description {
  NSMutableString *str = [NSMutableString stringWithFormat:@"%@ (@%@) (%ld)\n", self.name, self.username, (long)self.userID];
  [str appendFormat:@"%@\n", [self.userDescription description]];
  [str appendFormat:@"%@, %@\n", self.youFollow ? @"Following" : @"Not Following",
                    self.followsYou ? @"Follows You" : @"Does Not Follow You"];
  return str;
}

@end
