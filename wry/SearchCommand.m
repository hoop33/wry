//
//  SearchCommand.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "SearchCommand.h"
#import "ADNService.h"
#import "WryUtils.h"
#import "WryErrorCodes.h"
#import "NSString+Prefix.h"
#import "WryComposer.h"

@implementation SearchCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  // Rules:
  // 1. If it's a single word that starts with #, search by hashtag
  // 2. If it parses as name=value&name=value..., pass it through as search string
  // 3. Otherwise, set it as the text parameter
  NSString *searchString = params.count == 0 ? [[[WryComposer alloc] init] compose] : [params componentsJoinedByString:@" "];
  if (searchString.length == 0) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:[WryApplication application].errorDomain
                                   code:WryErrorCodeBadInput
                               userInfo:@{NSLocalizedDescriptionKey : @"You must specify a search string"}];
    }
    return NO;
  } else if ([searchString isHashtag]) {
    // Note we've already enforced the minimum number of parameters
    // and we know that searchString starts with # so we must strip
    return [WryUtils performListOperation:params
                            minimumParams:0
                             errorMessage:nil
                                    error:error
                                operation:^id(ADNService *service) {
                                  return [service searchPostsForHashtag:[searchString substringFromIndex:1]
                                                                  error:error];
                                }];
  } else {
    // Now, determine if we have name=value&... or just a string
    // Strip newlines--makes query easier to type in editor
    searchString = [searchString stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    NSMutableDictionary *criteria = [[NSMutableDictionary alloc] init];
    for (NSString *pair in [searchString componentsSeparatedByString:@"&"]) {
      // Confirm that each pair has one and only one equals sign that is not first or last character
      NSArray *nameValue = [pair componentsSeparatedByString:@"="];
      switch (nameValue.count) {
        case 1:
          [criteria setValue:nameValue[0] forKey:@"text"];
          break;
        case 2:
          [criteria setValue:nameValue[1] forKey:nameValue[0]];
          break;
        default:
          // ignore
          break;
      }
    }
    return [WryUtils performListOperation:params
                            minimumParams:0
                             errorMessage:nil
                                    error:error
                                operation:^id(ADNService *service) {
                                  return [service searchPosts:criteria
                                                        error:error];
                                }];
  }
}

- (NSString *)usage {
  return @"<search string>";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:
    @"Searches posts for the specified search string. Wry supports\n"
      @"three types of searches:\n"
      @"\n"
      @"   * Hashtag search\n"
      @"   * Text search\n"
      @"   * Advanced search\n"
      @"\n"
      @"For hashtag search, specify a single hashtag prefixed by #. Note that\n"
      @"most shells require that you surround this with quotes. Example:\n"
      @"\n"
      @"   wry search \"#wry\"\n"
      @"\n"
      @"For text search, specify your search terms, either with or without\n"
      @"quote marks. Example:\n"
      @"\n"
      @"   wry search boston celtics\n"
      @"\n"
      @"Specify advanced search strings by joining name=value pairs with &.\n"
      @"The names are any of the parameters supported by the App.net API.\n"
      @"For information on those parameters, see:\n"
      @"\n"
      @"   http://developers.app.net/docs/resources/post/search/\n"
      @"\n"
      @"Separate multiple values for a single name with spaces. Example:\n"
      @"\n"
      @"   wry search \"mentions=hoop33 wry&text=wry&link_domains=grailbox.com\"\n"
      @"\n"
  ];
  [help appendString:[WryComposer help]];
  return help;
}

- (NSString *)summary {
  return @"Search posts for search string";
}

@end
