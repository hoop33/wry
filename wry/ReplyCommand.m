//
//  ReplyCommand.m
//  wry
//
//  Created by Rob Warner on 3/21/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ReplyCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "WryComposer.h"

@implementation ReplyCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:1
                             errorMessage:@"You must specify a post ID"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  NSString *replyID = [params objectAtIndex:0];
                                  NSString *text = [[params subarrayWithRange:NSMakeRange(1, params.count - 1)]
                                                            componentsJoinedByString:@" "];
                                  if (!text.length) {
                                    WryComposer *composer = [[WryComposer alloc] init];
                                    text = [composer compose];
                                  }
                                  return [service createPost:text replyID:replyID error:error];
                                }];
}

- (NSString *)usage {
  return @"<postid> [text]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
          @"Replies to an existing post. You must specify the ID of the post to reply\n"
            @"to. If supplying the text of your reply as command-line arguments, note\n"
            "that the shell's parsing rules are respected, so escape\n"
            @"your text appropriately. Quotes are optional.\n"
            @"\n"];
  [help appendString:[WryComposer help]];
  return help;
}

- (NSString *)summary {
  return @"Reply to a post";
}

@end
