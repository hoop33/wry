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

@implementation ReplyCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:2
                             errorMessage:@"You must specify a post ID to reply to and a message"
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  NSString *replyID = [params objectAtIndex:0];
                                  NSString *text = [[params subarrayWithRange:NSMakeRange(1, params.count - 1)]
                                                            componentsJoinedByString:@" "];
                                  return [service createPost:text replyID:replyID
                                                       error:error];
                                }];
}

- (NSString *)usage {
  return @"<postid> <message>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Replies to an existing post. You must specify the ID of the post to reply\n"];
  [help appendString:@"to, as well as the text of your reply. Note that the shell's parsing rules are\n"];
  [help appendString:@"respected, so escape your text appropriately. Quotes are optional."];
  return help;
}

- (NSString *)summary {
  return @"Reply to a post";
}

@end
