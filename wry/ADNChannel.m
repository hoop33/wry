//
//  ADNChannel.m
//  wry
//
//  Created by Rob Warner on 5/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNChannel.h"
#import "ADNUser.h"
#import "ADNAnnotation.h"
#import "ADNAccessControlList.h"
#import "WryApplication.h"
#import "WryUtils.h"
#import "SeparatorSetting.h"

@implementation ADNChannel

static NSDictionary *NamesForTypes;

+ (void)initialize {
  NamesForTypes = @{
    @"net.patter-app.room" : @"Patter",
    @"net.app.core.pm" : @"Private"
  };
}

+ (NSString *)nameForType:(NSString *)type {
  return [[NamesForTypes allKeys] containsObject:type] ? [NamesForTypes objectForKey:type] : type;
}

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  NSString *namedType = [ADNChannel nameForType:self.type];
  SEL selector = NSSelectorFromString([namedType lowercaseString]);
  if ([self respondsToSelector:selector]) {
    IMP imp = [self methodForSelector:selector];
    NSString *(*func)(id, SEL) = (void *) imp;
    NSString *content = func(self, selector);
    [str appendString:content];
  } else {
    [str appendFormat:@"Type: %@", namedType];
    [str appendFormat:@"\nOwner: %@", (self.owner == nil ? @"[RETIRED OWNER]" : [self.owner shortDescription])];
    [str appendFormat:@"\nID: %ld", self.objectID];
    for (ADNAnnotation *annotation in self.annotations) {
      [str appendFormat:@"\n%@", [annotation description]];
    }
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

- (NSString *)patter {
  NSMutableString *str = [[NSMutableString alloc] init];
  NSString *name = nil;
  NSString *blurb = nil;
  for (ADNAnnotation *annotation in self.annotations) {
    NSDictionary *dictionary = annotation.value;
    if ([dictionary.allKeys containsObject:@"blurb"]) {
      name = [dictionary objectForKey:@"name"];
      blurb = [dictionary objectForKey:@"blurb"];
      break;
    }
  }
  [str appendFormat:@"%@ Patter Room (%ld)", name == nil ? @"Unknown" : name, self.objectID];
  if (blurb != nil) {
    [str appendFormat:@"\n%@", blurb];
  }
  return str;
}

- (NSString *)private {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendFormat:@"Private Channel (%ld)", self.objectID];
  [str appendFormat:@"\nUsers: %ld", self.owner.objectID];
  for (NSNumber *userID in self.writers.userIDs) {
    [str appendFormat:@", %@", userID];
  }
  return str;
}

@end
