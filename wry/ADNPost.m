//
//  ADNPost.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNPost.h"
#import "ADNUser.h"

@implementation ADNPost

- (NSString *)description {
  NSString *str = [NSString stringWithFormat:@"%@ (%@)\n", self.user.name, self.user.username];
  str = [str stringByAppendingFormat:@"%@\n", self.text];
  str = [str stringByAppendingFormat:@"ID: %ld -- %@", self.postID, self.createdAt];
  return str;
}

@end
