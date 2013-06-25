//
//  ADNLink.m
//  wry
//
//  Created by Rob Warner on 6/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNLink.h"
#import "WrySettings.h"

@implementation ADNLink

- (NSString *)description {
  return [NSString stringWithFormat:@"[%@](%@)", self.text, self.url];
}

- (NSString *)colorDescription {
  return [NSString stringWithFormat:@"[%@](%@)",
    [self colorize:self.text colorSetting:SettingsTextColor],
    [self colorize:self.url colorSetting:SettingsLinkColor]
  ];
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
