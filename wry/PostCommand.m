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

@implementation PostCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:0
                             errorMessage:nil
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  NSString *text = [params componentsJoinedByString:@" "];
                                  if (!text.length) {
                                    WryComposer *composer = [[WryComposer alloc] init];
                                    text = [composer compose];
                                  }
                                  return [service createPost:text replyID:nil error:error];
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
