//
//  ADNMessage.m
//  wry
//
//  Created by Rob Warner on 05/06/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNMessage.h"
#import "ADNUser.h"
#import "ADNAnnotation.h"
#import "WryApplication.h"
#import "SeparatorSetting.h"
#import "WryUtils.h"
#import "ADNLink.h"
#import "ADNHashtag.h"

@implementation ADNMessage

- (NSString *)description {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:(self.user == nil ? @"[RETIRED USER]" : [self.user shortDescription])];
  [str appendFormat:@"\nChannel ID: %ld", self.channelID];
  [str appendFormat:@"\n%@", (self.text == nil ? @"[REDACTED]" : self.text)];
  [str appendFormat:@"\nID: %ld -- %@", self.objectID, self.createdAt];
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation description]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

- (NSString *)colorDescription {
  NSMutableString *str = [[NSMutableString alloc] init];
  [str appendString:(self.user == nil ? [self colorize:@"[RETIRED USER]" colorSetting:WryColorAlert] : [self.user colorShortDescription])];
  [str appendFormat:@"\nChannel ID: %@", [self colorize:[NSString stringWithFormat:@"%ld", self.channelID] colorSetting:WryColorID]];
  [str appendFormat:@"\n%@", (self.text == nil ? [self colorize:@"[REDACTED]" colorSetting:WryColorAlert] : [self colorize:self.text colorSetting:WryColorText])];
  [str appendFormat:@"\nID: %@ -- %@",
                    [self colorize:[NSString stringWithFormat:@"%ld", self.objectID] colorSetting:WryColorID],
                    [self colorize:[self.createdAt description] colorSetting:WryColorMuted]];
  for (ADNLink *link in self.links) {
    [str appendFormat:@"\n%@", [link colorDescription]];
  }
  for (ADNHashtag *hashtag in self.hashtags) {
    [str appendFormat:@"\n%@", [hashtag colorDescription]];
  }
  for (ADNAnnotation *annotation in self.annotations) {
    [str appendFormat:@"\n%@", [annotation colorDescription]];
  }
  [str appendFormat:@"\n%@", [[WryApplication application].settings stringValue:[WryUtils nameForSettingForClass:[SeparatorSetting class]]]];
  return str;
}

@end
