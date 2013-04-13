//
//  ADNFile.m
//  wry
//
//  Created by Rob Warner on 04/11/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNFile.h"

@implementation ADNFile

- (NSString *)description {
  return [NSString stringWithFormat:@"ID:%ld   %@   %@ (%ldB)", self.fileID, self.createdAt, self.name, self.totalSize];
}

@end
