//
//  PmCommand.m
//  wry
//
//  Created by Rob Warner on 05/07/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "PmCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "WryComposer.h"
#import "WryEnhancer.h"
#import "UnescapeBangEnhancer.h"

@implementation PmCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return [WryUtils performObjectOperation:params
                            minimumParams:1
                             errorMessage:@"You must specify a user to send to"
                                formatter:formatter
                                  options:options
                                    error:error
                                operation:(ADNOperationBlock) ^(ADNService *service) {
                                  NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
                                  NSMutableArray *users = [NSMutableArray array];
                                  NSString *replyID = nil;
                                  NSString *text = nil;
                                  for (NSString *param in params) {
                                    if ([param hasPrefix:@"@"]) {
                                      [users addObject:param];
                                    } else if (replyID == nil &&
                                      [numbers isSupersetOfSet:
                                        [NSCharacterSet characterSetWithCharactersInString:param]]) {
                                      replyID = param;
                                    } else {
                                      id <WryEnhancer> unescapeBangEnhancer = [[UnescapeBangEnhancer alloc] init];
                                      text = [unescapeBangEnhancer enhance:param];
                                    }
                                  }
                                  if (!text.length) {
                                    WryComposer *composer = [[WryComposer alloc] init];
                                    text = [composer compose];
                                  }
                                  return [service sendMessage:users replyID:replyID
                                                    channelID:nil text:text
                                                        error:error];
                                }];
}

- (NSString *)usage {
  return @"<@username1 @username2 @username3 ...> [messageid] [text]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
    @"Sends a private message to the specified user or users. You can specify\n"
      @"multiple users by separating with spaces. You can also reply to a message\n"
      @"by specifying the ID of the message to reply to. If supplying the text of\n"
      @"your message as command-line arguments, note that the shell's parsing rules\n"
      @"are respected, so escape your text appropriately.\n"
      "Note that quotes are NOT optional.\n"
      @"\n"];
  [help appendString:[WryComposer help]];
  return help;
}

- (NSString *)summary {
  return @"Send a private message";
}

@end
