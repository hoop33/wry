//
//  ADNLink.m
//  wry
//
//  Created by Rob Warner on 6/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNLink.h"

@implementation ADNLink

- (NSString *)description {
  return [NSString stringWithFormat:@"[%@](%@)", self.text, self.url];
}

@end
