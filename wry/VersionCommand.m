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
  [app println:@"Copyright (C) 2013, Rob Warner (@hoop33)"];
  [app println:@"http://grailbox.com/wry"];
  [app println:@""];
  [app println:[NSString stringWithFormat:@"%@ uses SSKeychain (https://github.com/soffes/sskeychain) for Keychain access.",
                                          app.appName]];
  return YES;
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  return @"Displays version information about this application";
}

- (NSString *)summary {
  return @"Display version information";
}

@end
