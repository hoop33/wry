//
//  ALFREDFormatter.m
//  wry
//
//  Created by Rob Warner on 4/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ALFREDFormatter.h"
#import "ADNPost.h"
#import "ADNUser.h"
#import "ADNUserDescription.h"
#import "WryCommand.h"
#import "WryUtils.h"

@interface ALFREDFormatter ()
- (NSString *)toItemXML:(id)item;
@end

@implementation ALFREDFormatter

- (NSString *)format:(ADNResponse *)response {
  NSMutableString *string = [NSMutableString string];
  [string appendString:@"<?xml version='1.0'?>\n"];
  [string appendString:@"<items>\n"];
  if ([response.object isKindOfClass:[NSArray class]]) {
    for (id item in (NSArray *) response.object) {
      [string appendString:[self toItemXML:item]];
    }
  } else {
    [string appendString:[self toItemXML:response.object]];
  }
  [string appendString:@"</items>\n"];
  return string;
}

- (NSString *)summary {
  return @"The XML format required for Alfred Workflows";
}

- (NSString *)toItemXML:(id)item {
  NSMutableString *string = [NSMutableString string];
  if ([item isKindOfClass:[ADNPost class]]) {
    ADNPost *post = (ADNPost *) item;
    [string appendFormat:@"<item uid='%ld' arg='%ld' valid='YES'>\n", post.postID, post.postID];
    [string appendFormat:@"<title>%@</title>\n", [[NSXMLNode textWithStringValue:post.text] XMLString]];
    [string appendFormat:@"<subtitle>%@ (@%@) (%ld)</subtitle>\n", post.user.name, post.user.username,
                         post.user.userID];
    [string appendFormat:@"</item>\n"];
  } else if ([item isKindOfClass:[ADNUser class]]) {
    ADNUser *user = (ADNUser *) item;
    [string appendFormat:@"<item uid='%ld' arg='%ld' valid='YES'>\n", user.userID, user.userID];
    [string appendFormat:@"<title>%@ (@%@) (%ld)</title>\n", user.name, user.username, user.userID];
    [string appendFormat:@"<subtitle>%@</subtitle>\n",
                         [[NSXMLNode textWithStringValue:user.userDescription.text] XMLString]];
    [string appendFormat:@"</item>\n"];
  } else if ([item conformsToProtocol:@protocol(WryCommand)]) {
    id <WryCommand> command = [[item alloc] init];
    NSString *name = [WryUtils nameForCommand:command];
    [string appendFormat:@"<item uid='%@' arg='%@' autocomplete='%@' valid='YES'>\n", name, name, name];
    [string appendFormat:@"<title>%@</title>\n", name];
    [string appendFormat:@"<subtitle>%@</subtitle>\n", [command summary]];
    [string appendFormat:@"<icon>icon.png</icon>"];
    [string appendFormat:@"</item>\n"];
  }
  return string;
}

@end
