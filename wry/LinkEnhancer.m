//
//  LinkEnhancer.m
//  wry
//
//  Created by Rob Warner on 6/16/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "LinkEnhancer.h"
#import "ADNLink.h"

@implementation LinkEnhancer

// This enhancer finds any links in Markdown syntax and transforms them into real links.
// Note that the link-matching part of the regex is simple--future opportunity to enhance, if necessary.
- (id)enhance:(id)object {
  if ([object isKindOfClass:[NSMutableDictionary class]]) {
    NSMutableDictionary *dictionary = (NSMutableDictionary *) object;
    NSMutableString *text = [dictionary[@"text"] mutableCopy];
    NSMutableArray *links = [NSMutableArray array];

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[(.+?)\\]\\((.+?)\\)"
                                                                           options:0
                                                                             error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:text
                                                    options:0
                                                      range:NSMakeRange(0, [text length])];
    while (match) {
      NSRange matchRange = [match range];
      NSRange textRange = [match rangeAtIndex:1];
      NSRange linkRange = [match rangeAtIndex:2];

      ADNLink *link = [[ADNLink alloc] init];
      link.url = [text substringWithRange:linkRange];
      link.position = textRange.location - 1; // The new pos of the text, once we drop the paren
      link.length = textRange.length;
      [links addObject:[link asDictionary]];

      [text replaceCharactersInRange:matchRange withString:[[text substringWithRange:textRange] copy]];
      match = [regex firstMatchInString:text
                                options:0
                                  range:NSMakeRange(0, [text length])];
    }
    if (links.count > 0) {
      dictionary[@"text"] = [text copy];
      dictionary[@"entities"] = @{
        @"links" : links
      };
    }
  }
  return object;
}

@end
