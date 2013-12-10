//
//  UsersCommand.m
//  wry
//
//  Created by Rob Warner on 04/27/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UsersCommand.h"
#import "SSKeychain.h"
#import "WrySettings.h"
#import "NSString+Prefix.h"
#import "WryUtils.h"
#import "UserSetting.h"

@implementation UsersCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  WryApplication *app = [WryApplication application];
  if (params == nil || params.count == 0) {
    NSString *defaultUser = [app.settings stringValue:[WryUtils nameForSettingForClass:[UserSetting class]]];
    for (NSDictionary *account in [SSKeychain accountsForService:app.appName]) {
      NSString *user = [account valueForKey:@"acct"];
      [app print:[defaultUser isEqualToString:user] ? @"*" : @" "];
      [app println:user];
    }
  } else {
    NSString *command = [params objectAtIndex:0];
    if ([@[@"delete", @"default"] containsObject:command]) {
      if (params.count < 2) {
        [app println:[NSString stringWithFormat:@"You must specify the user to %@", [params objectAtIndex:0]]];
      } else {
        NSString *user = [[params objectAtIndex:1] deatify];
        if ([SSKeychain passwordForService:app.appName account:user] == nil) {
          [app println:[NSString stringWithFormat:@"User '%@' does not exist.", user]];
        } else {
          if ([command isEqualToString:@"delete"]) {
            [SSKeychain deletePasswordForService:app.appName account:user];
            [app println:[NSString stringWithFormat:@"Deleted user '%@'", user]];
          } else {
            [app.settings setObject:user forKey:[WryUtils nameForSettingForClass:[UserSetting class]]];
            [app println:[NSString stringWithFormat:@"User '%@' now default", user]];
          }
        }
      }
    } else {
      [app println:[NSString stringWithFormat:@"%@: '%@' is not a users command. See '%@ help users'.", app.appName,
                                              command, app.appName]];
    }
  }
  return YES;
}

- (NSString *)usage {
  return @"[option] [user]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Manages the users you've authorized on this computer. These are the users\n"];
  [help appendString:@"you can pass using the -u, --user flag to run a command as that user.\n"];
  [help appendString:@"Options:\n"];
  [help appendString:@"\n"];
  [help appendString:@"   users                  List the authorized users\n"];
  [help appendString:@"   users delete <user>    Delete the specified user\n"];
  [help appendString:@"   users default <user>   Make the specified user the default\n"];
  return help;
}

- (NSString *)summary {
  return @"Manage the users you've authorized on this computer";
}

@end
