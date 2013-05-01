//
//  NSString+Atification.m
//  wry
//
//  Created by Rob Warner on 5/1/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "NSString+Atification.h"

@implementation NSString (Atification)

- (NSString *)atify {
  return [self hasPrefix:@"@"] ? self : [NSString stringWithFormat:@"@%@", self];
}

- (NSString *)deatify {
  return [self hasPrefix:@"@"] ? [self substringFromIndex:1] : self;
}

@end
