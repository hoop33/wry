//
//  PostCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "PostCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "WryComposer.h"
#import "WryEnhancer.h"
#import "TextTooLongEnhancer.h"
#import "UnescapeBangEnhancer.h"

@implementation PostCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:0
                             errorMessage:nil
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  id <WryEnhancer> unescapeBangEnhancer = [[UnescapeBangEnhancer alloc] init];
                                  NSString *text = [unescapeBangEnhancer enhance:[params componentsJoinedByString:@" "]];
                                  if (!text.length) {
                                    WryComposer *composer = [[WryComposer alloc] init];
                                    text = [composer compose];
                                  }

                                  NSArray *posts = @[text];
                                  if (text.length > kMaxTextLength) {
                                    id <WryEnhancer> textTooLongEnhancer = [[TextTooLongEnhancer alloc] init];
                                    id enhanced = [textTooLongEnhancer enhance:text];
                                    if (enhanced) {
                                      posts = [enhanced isKindOfClass:[NSArray class]] ? enhanced : @[(NSString *) enhanced];
                                    } else {
                                      posts = nil;
                                    }
                                  }

                                  ADNResponse *response = nil;
                                  for (NSString *post in posts) {
                                    response = [service createPost:post replyID:nil error:error];
                                    if (response == nil) break;
                                  }
                                  return response;
                                }];
}

- (NSString *)usage {
  return @"[text]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
    @"Creates a new post with the text you specify. If supplying text as command-\n"
      @"line arguments, note that the shell's parsing rules are respected, so escape\n"
      @"your text appropriately. Quotes are optional.\n"
      @"\n"];
  [help appendString:[WryComposer help]];
  return help;
}

- (NSString *)summary {
  return @"Create a post";
}

@end
