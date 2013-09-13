//
//  ADNFile.m
//  wry
//
//  Created by Rob Warner on 04/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNFile.h"
#import "ADNAnnotation.h"
#import "WryApplication.h"
#import "WrySettings.h"
#import "SeparatorSetting.h"
#import "WryUtils.h"

@implementation ADNFile

- (NSString *)description {
  NSMutableString *str = [NSMutableString string];
  [str appendFormat:@"ID:%ld   %@   %@ (%ldB)", self.fileID, self.createdAt, self.name, self.totalSize];
  [str appendFormat:@"\n(%@)   SHA1: %@", self.isPublic ? @"Public" : @"Private", self.sha1];
  [str appendFormat:@"\n%@", self.shortUrl.length > 0 ? self.shortUrl : self.url];
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

- (NSString *)colorDescription {
  NSMutableString *str = [NSMutableString string];
  [str appendFormat:@"ID:%@   %@   %@ (%@)",
                    [self colorize:[NSString stringWithFormat:@"%ld", self.fileID] colorSetting:WryColorID],
                    [self colorize:[self.createdAt description] colorSetting:WryColorMuted],
                    [self colorize:self.name colorSetting:WryColorName],
                    [self colorize:[NSString stringWithFormat:@"%ldB", self.totalSize] colorSetting:WryColorID]
  ];
  [str appendFormat:@"\n(%@)   SHA1: %@",
                    self.isPublic ? @"Public" : @"Private",
                    [self colorize:self.sha1 colorSetting:WryColorMuted]
  ];
  [str appendFormat:@"\n%@", [self colorize:(self.shortUrl.length > 0 ? self.shortUrl : self.url)
                               colorSetting:WryColorLink]];
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation colorDescription]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

@end
