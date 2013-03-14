//
//  ADNUser.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNUser.h"

@implementation ADNUser

- (NSString *)description {
  NSString *str = [NSString stringWithFormat:@"%@ (%@)\n", self.name, self.username];
  str = [str stringByAppendingFormat:@"%@, %@\n", self.youFollow ? @"Following" : @"Not Following",
                                     self.followsYou ? @"Follows You" : @"Does Not Follow You"];
  return str;
}

@end
