//
//  PostCommand.m
//  wry
//
//  Created by Rob Warner on 3/17/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "PostCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation PostCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performObjectOperation:app
                                       params:params
                                minimumParams:1
                               successMessage:@"Posted:"
                                 errorMessage:@"You must specify a message"
                                        error:error
                                    operation:(ADNOperationBlock) ^(ADNService *service) {
                                      return [service createPost:[params componentsJoinedByString:@" "] replyID:nil
                                                           error:error];
                                    }];
}

- (NSString *)usage {
  return @"<text>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Creates a new post with the text you specify. Note that the shell's parsing\n"];
  [help appendString:@"rules are respected, so escape your text appropriately. Quotes are optional."];
  return help;
}

- (NSString *)summary {
  return @"Create a post";
}

@end
