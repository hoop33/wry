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

@implementation PostCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  ADNOperationBlock postOperation = ^(ADNService *service) {
    NSString *text = [params componentsJoinedByString:@" "];
    if (!text.length) {
      NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
      NSData *textData = [input readDataToEndOfFile];
      text = [[NSString alloc]
              initWithData:textData encoding:NSUTF8StringEncoding];

      /* Remove any final newline. */
      if ([text hasSuffix:@"\n"]) {
        text = [text substringToIndex:text.length - 1];
      }
    }
    return [service createPost:text replyID:nil error:error];
  };
  return [WryUtils performObjectOperation:app
                                   params:params
                            minimumParams:0
                             errorMessage:@"You must specify a message"
                                    error:error
                                operation:postOperation];
}

- (NSString *)usage {
  return @"[<text>]\n(omit text to read from stdin)";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
   @"Creates a new post with the text you specify. If supplying text as command-\n"
   @"line arguments, note that the shell's parsing rules are respected, so escape\n"
   @"your text appropriately. Quotes are optional.\n"
   @"\n"
   @"Alternatively, supply no arguments and the post body will be read from stdin.\n"
   @"Enter EOF (^D) to end the post. This lets you avoid all shell quoting, as\n"
   @"well as create posts by piping input from other commands."];
  return help;
}

- (NSString *)summary {
  return @"Create a post";
}

@end
