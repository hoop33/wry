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

@implementation ADNFile

- (NSString *)description {
  NSMutableString *str = [NSMutableString string];
  [str appendFormat:@"ID:%ld   %@   %@ (%ldB)", self.fileID, self.createdAt, self.name, self.totalSize];
  [str appendFormat:@"\n(%@)   SHA1: %@", self.isPublic ? @"Public" : @"Private", self.sha1];
  [str appendFormat:@"\n%@", self.shortUrl.length > 0 ? self.shortUrl : self.url];
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings getString:SettingsSeparator]];
  return str;
}

@end
