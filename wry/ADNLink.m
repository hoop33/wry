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
  return [self.text isEqualToString:self.url] ? self.url : [NSString stringWithFormat:@"[%@](%@)", self.text, self.url];
}

- (NSString *)colorDescription {
  return [self.text isEqualToString:self.url] ? [self colorize:self.url colorSetting:WryColorLink] :
    [NSString stringWithFormat:@"[%@](%@)",
                               [self colorize:self.text colorSetting:WryColorText],
                               [self colorize:self.url colorSetting:WryColorLink]];
}

- (NSDictionary *)asDictionary {
  // Note that we omit text, as per ADN guidelines
  return @{
    @"url" : self.url,
    @"pos" : [NSNumber numberWithLong:self.position],
    @"len" : [NSNumber numberWithLong:self.length]
  };
}

@end
