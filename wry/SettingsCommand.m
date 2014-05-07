//
//  SettingsCommand.m
//  wry
//
//  Created by Rob Warner on 9/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "SettingsCommand.h"
#import "ADNResponse.h"
#import "WryUtils.h"

@implementation SettingsCommand

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  ADNResponse *response = [[ADNResponse alloc] initWithData:nil mapping:nil reverse:NO error:error];
  NSArray *settingsClasses = [WryUtils allSettings];
  NSMutableArray *settings = [[NSMutableArray alloc] initWithCapacity:settingsClasses.count];
  for (Class cls in settingsClasses) {
    [settings addObject:[[cls alloc] init]];
  }
  response.object = settings;
  WryApplication *app = [WryApplication application];
  [app println:[formatter format:response]];
  return YES;
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Lists all the available settings.";
}

- (NSString *)summary {
  return @"List available settings";
}

@end
