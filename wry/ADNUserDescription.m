//
//  ADNUserDescription.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNUserDescription.h"

@implementation ADNUserDescription

- (NSString *)description {
  return self.text;
}

- (NSString *)colorDescription {
  return [self colorize:self.text colorSetting:WryColorText];
}

@end