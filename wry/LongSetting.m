//
//  LongSetting.m
//  wry
//
//  Created by Rob Warner on 8/8/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "LongSetting.h"
#import "WryApplication.h"

@implementation LongSetting

- (NSString *)shortFlag {
  return @"l";
}

- (NSString *)summary {
  return @"How to handle too-long post/replies/messages";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendFormat:@"App.net restricts posts, replies, and messages to %d characters.\n", [WryApplication maximumPostLength]];
  [help appendFormat:@"If your text exceeds this limit, %@ will do one of four things:\n", [WryApplication application].appName];
  [help appendString:
    @"\n* ask        Ask you whether to truncate or reject\n"
      @"* reject     Reject the text (not send it)\n"
      @"* split      Split the text into multiple posts/replies/messages\n"
      @"* truncate   Truncate the text"];
  return help;
}

- (NSUInteger)numberOfParameters {
  return 1;
}

- (NSArray *)allowedValues {
  return @[@"ask", @"reject", @"split", @"truncate"];
}

- (WrySettingType)type {
  return WrySettingStringType;
}

@end
