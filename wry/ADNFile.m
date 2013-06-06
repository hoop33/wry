//
//  ADNFile.m
//  wry
//
//  Created by Rob Warner on 04/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNFile.h"
#import "ADNAnnotation.h"

@implementation ADNFile

- (NSString *)description {
  NSMutableString *str = [NSMutableString string];
  [str appendFormat:@"ID:%ld   %@   %@ (%ldB)", self.fileID, self.createdAt, self.name, self.totalSize];
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  return str;
}

@end
