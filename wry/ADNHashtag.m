//
//  ADNHashtag.m
//  wry
//
//  Created by Rob Warner on 6/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNHashtag.h"
#import "WrySettings.h"

@implementation ADNHashtag

- (NSString *)description {
  return [NSString stringWithFormat:@"#%@", self.text];
}

- (NSString *)colorDescription {
  return [self colorize:[NSString stringWithFormat:@"#%@", self.text] colorSetting:SettingsHashtagColor];
}

@end
