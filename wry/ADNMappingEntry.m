//
//  ADNMappingEntry.m
//  wry
//
//  Created by Rob Warner on 6/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNMappingEntry.h"
#import "ADNJSONMapping.h"

@implementation ADNMappingEntry

+ (ADNMappingEntry *)mappingEntry:(NSString *)from to:(NSString *)to mapping:(ADNJSONMapping *)mapping {
  ADNMappingEntry *mappingEntry = [[ADNMappingEntry alloc] init];
  mappingEntry.from = from;
  mappingEntry.to = to == nil ? from : to;
  mappingEntry.mapping = mapping;
  return mappingEntry;
}

@end
