//
//  FormattersCommand.m
//  wry
//
//  Created by Rob Warner on 9/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "FormattersCommand.h"
#import "WryUtils.h"

@implementation FormattersCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  ADNResponse *response = [[ADNResponse alloc] initWithData:nil];
  NSArray *formattersClasses = [WryUtils allFormatters];
  NSMutableArray *formatters = [[NSMutableArray alloc] initWithCapacity:formattersClasses.count];
  for (Class cls in formattersClasses) {
    [formatters addObject:[[cls alloc] init]];
  }
  response.object = formatters;
  WryApplication *app = [WryApplication application];
  [app println:[app.formatter format:response]];
  return YES;
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Lists all the available formatters.";
}

- (NSString *)summary {
  return @"List available formatters";
}

@end
