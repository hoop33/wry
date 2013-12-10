//
//  ADNHashtag.m
//  wry
//
//  Created by Rob Warner on 6/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNHashtag.h"

@implementation ADNHashtag

- (NSString *)description {
  return [NSString stringWithFormat:@"#%@", self.text];
}

- (NSString *)colorDescription {
  return [self colorize:[NSString stringWithFormat:@"#%@", self.text] colorSetting:WryColorHashtag];
}

@end
