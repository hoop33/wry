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

- (NSString *)shortDescription {
  return [NSString stringWithFormat:@"%@ (@%@) (%ld) %@==%@ You\n", self.name, self.username, (long)self.userID,
                   (self.youFollow ? @"<" : @""), (self.followsYou ? @">" : @"")];
}

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:[self shortDescription]];
  [str appendFormat:@"%@\n", [self.userDescription description]];
  return str;
}

@end
