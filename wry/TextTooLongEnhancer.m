//
//  TextTooLongEnhancer.m
//  wry
//
//  Created by Rob Warner on 6/27/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "TextTooLongEnhancer.h"
#import "WryApplication.h"
#import "WrySettings.h"

@interface TextTooLongEnhancer ()
- (id)ask:(NSString *)text;
- (id)split:(NSString *)text;
@end

@implementation TextTooLongEnhancer

- (id)enhance:(id)object {
  if ([object isKindOfClass:[NSString class]]) {
    NSString *text = (NSString *)object;
    if (text.length > kMaxTextLength) {
      switch ([[WryApplication application].settings getInteger:SettingsTextTooLongOption]) {
        case TextTooLongOptionAsk:
          object = [self ask:text];
          break;
        case TextTooLongOptionReject:
          object = nil;
          break;
        case TextTooLongOptionTruncate:
          object = [text substringToIndex:kMaxTextLength];
          break;
        case TextTooLongOptionSplit:
          object = [self split:text];
          break;
        default:
          break;
      }
    }
  }
  return object;
}

- (id)ask:(NSString *)text {
  WryApplication *app = [WryApplication application];
  NSInteger overage = text.length - kMaxTextLength;
  assert(overage > 0);
  [app println:[NSString stringWithFormat:@"Warning: Text exceeds %d-character limit by %ld character%@.",
                         kMaxTextLength, overage, (overage == 1 ? @"" : @"s")]];
  [app println:@""];
  [app println:@"Text would include:"];
  [app println:@""];
  [app println:[NSString stringWithFormat:@"%@", [text substringToIndex:kMaxTextLength]]];
  [app println:@""];
  [app println:@"Text would omit:"];
  [app println:[NSString stringWithFormat:@"%@", [text substringFromIndex:kMaxTextLength]]];
  [app println:@""];
  [app print:@"Use this text? (y/N) --> "];
  NSString *useText = [app getInput];
  return [[useText lowercaseString] hasPrefix:@"y"] ? [text substringToIndex:kMaxTextLength] : nil;
}

- (id)split:(NSString *)text {
  // Return an array of texts, split into kMaxTextLength-ish chunks on word boundaries
  NSMutableArray *texts = [NSMutableArray array];
  NSUInteger index = 0, end = text.length;
  while (index < end) {
    NSUInteger maxLength = MIN(kMaxTextLength, end - index);

    // Grab a maxLength chunk
    NSString *substring = [text substringWithRange:NSMakeRange(index, maxLength)];

    // Walk backwards to find some whitespace
    NSUInteger lastIndex = substring.length - 1;
    while (lastIndex > 1 &&
            ![[NSCharacterSet whitespaceAndNewlineCharacterSet]
              characterIsMember:[substring characterAtIndex:lastIndex]]) {
      --lastIndex;
    }
    // If we didn't find whitespace, use a maxLength chunk
    substring = [substring substringToIndex:lastIndex == 1 ? maxLength : lastIndex];

    // Add the chunk to the list of texts
    [texts addObject:substring];

    // Move the index
    index += substring.length + 1;
  }
  return texts;
}

@end
