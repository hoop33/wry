//
//  ADNUser.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNUser.h"
#import "ADNUserDescription.h"
#import "ADNAnnotation.h"
#import "WrySettings.h"
#import "NSString+Atification.h"
#import "WryApplication.h"
#import "WryUtils.h"
#import "SeparatorSetting.h"

@implementation ADNUser

- (NSString *)shortDescription {
  return [NSString stringWithFormat:@"%@ (%@) (%ld) %@--%@ You",
                                    self.name,
                                    [self.username atify],
                                    (long) self.userID,
                                    (self.youFollow ? @"<" : @""), (self.followsYou ? @">" : @"")
  ];
}

- (NSString *)colorShortDescription {
  return [NSString stringWithFormat:@"%@ (%@) (%@) %@--%@ You",
                                    [self colorize:self.name colorSetting:WryColorName],
                                    [self colorize:[self.username atify] colorSetting:WryColorUser],
                                    [self colorize:[NSString stringWithFormat:@"%ld", (long) self.userID]
                                      colorSetting:WryColorID],
                                    (self.youFollow ? @"<" : @""),
                                    (self.followsYou ? @">" : @"")
  ];
}

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:[self shortDescription]];
  if (self.userDescription != nil) {
    [str appendFormat:@"\n%@", [self.userDescription description]];
  }
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

- (NSString *)colorDescription {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:[self colorShortDescription]];
  if (self.userDescription != nil) {
    [str appendFormat:@"\n%@", [self.userDescription colorDescription]];
  }
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

@end
