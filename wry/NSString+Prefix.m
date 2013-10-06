//
//  NSString+Prefix.m
//  wry
//
//  Created by Rob Warner on 5/1/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "NSString+Prefix.h"

@implementation NSString (Prefix)

- (NSString *)atify {
  return [self ensurePrefix:@"@"];
}

- (NSString *)deatify {
  return [self ensureNoPrefix:@"@"];
}

- (NSString *)hashtagify {
  return [self ensurePrefix:@"#"];
}

- (NSString *)dehashtagify {
  return [self ensureNoPrefix:@"#"];
}

- (NSString *)ensurePrefix:(NSString *)prefix {
  return [self hasPrefix:prefix] ? self : [NSString stringWithFormat:@"%@%@", prefix, self];
}

- (NSString *)ensureNoPrefix:(NSString *)prefix {
  return [self hasPrefix:prefix] ? [self substringFromIndex:prefix.length] : self;
}

@end
