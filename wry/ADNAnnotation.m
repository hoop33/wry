//
//  ADNAnnotation.m
//  wry
//
//  Created by Rob Warner on 5/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNAnnotation.h"

@interface ADNAnnotation()
- (void)appendDictionary:(NSDictionary *)dictionary toString:(NSMutableString *)string indentationLevel:(NSUInteger)level;
@end

@implementation ADNAnnotation

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendFormat:@"* %@", self.type];
  [self appendDictionary:self.value toString:str indentationLevel:2];
  return str;
}

- (void)appendDictionary:(NSDictionary *)dictionary toString:(NSMutableString *)string indentationLevel:(NSUInteger)level {
  for (NSString *key in [dictionary allKeys]) {
    id value = [dictionary valueForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
      [self appendDictionary:value toString:string indentationLevel:(level + 2)];
    } else {
      [string appendString:@"\n"];
      for (int i = 0; i < level; i++) {
        [string appendString:@" "];
      }
      [string appendFormat:@"%@ : %@", key, value];
    }
  }
}

@end
