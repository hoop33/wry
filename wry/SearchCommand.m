//
//  SearchCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "SearchCommand.h"
#import "ADNService.h"
#import "CommandUtils.h"

@implementation SearchCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  return [CommandUtils performListOperation:app
                                     params:params
                              minimumParams:1
                             successMessage:@"Search results:"
                               errorMessage:@"You must specify a hashtag to search for"
                                      error:error
                                  operation:^id(ADNService *service) {
                                    NSString *hashtag = [params objectAtIndex:0];
                                    if (hashtag.length > 0 && [hashtag hasPrefix:@"#"]) {
                                      hashtag = [hashtag substringFromIndex:1];
                                    }
                                    return [service searchPosts:hashtag error:error];
                                  }];
}

- (NSString *)usage {
  return @"<hashtag>";
}

- (NSString *)help {
  return @"Searches posts for the specified hashtag.";
}

- (NSString *)summary {
  return @"Search for hashtag";
}

@end
