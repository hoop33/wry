//
//  JSONFormatter.m
//  wry
//
//  Created by Rob Warner on 4/6/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "JSONFormatter.h"

@implementation JSONFormatter

- (NSString *)format:(ADNResponse *)response {
  return response.json;
}

- (NSString *)summary {
  return @"The raw App.net JSON response";
}

@end
