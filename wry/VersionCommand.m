//
//  VersionCommand.m
//  wry
//
//  Created by Rob Warner on 3/20/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "VersionCommand.h"

@implementation VersionCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  [app println:[NSString stringWithFormat:@"%@ version %@", app.appName, app.version]];
  return YES;
}

- (NSString *)help {
  return @"This is the help for the version command";
}

- (NSString *)summary {
  return @"This is the summary for the version command";
}

@end
