//
//  UsersCommand.m
//  wry
//
//  Created by Rob Warner on 04/27/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "UsersCommand.h"
#import "SSKeychain.h"
#import "WryUtils.h"
#import "ADNService.h"

@implementation UsersCommand

- (BOOL)run:(WryApplication *)app params:(NSArray *)params error:(NSError **)error {
  for (NSDictionary *account in [SSKeychain accountsForService:app.appName]) {
    NSString *acct = [account valueForKey:@"acct"];
    [app println:[NSString stringWithFormat:@"%@:", acct]];
    app.user = acct;
    app.accessToken = [SSKeychain passwordForService:app.appName account:acct];
    [WryUtils performObjectOperation:app
                              params:nil
                       minimumParams:0
                        errorMessage:nil
                               error:error
                           operation:^id(ADNService *service) {
                             return [service getUser:error];
                           }];
  }
  return YES;
}

- (NSString *)usage {
  return @"";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendString:@"Lists the users you've authorized on this computer. These are the users\n"];
  [help appendString:@"you can pass using the -u, --user flag to run a command as that user.\n"];
  [help appendString:@"All commands will run as the 'default' user if no user is specified.\n"];
  [help appendString:@"NOTE: The users are actually keys in the Mac OS X keychain, which you\n"];
  [help appendString:@"can view using the Keychain Access application. You can use arbitrary\n"];
  [help appendString:@"names that don't necessarily match your App.net user names."];
  return help;
}

- (NSString *)summary {
  return @"List the users you've authorized on this computer";
}

@end
