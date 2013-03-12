//
//  AuthorizeCommand.m
//  wry
//
//  Created by Rob Warner on 3/12/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "AuthorizeCommand.h"

@implementation AuthorizeCommand

- (int)run:(WryApplication *)app params:(NSArray *)params {
  [app println:[NSString stringWithFormat:@"You authorize %@ through a Web browser on the App.net website.",
                                          app.appName]];
  [app println:[NSString stringWithFormat:@"After signing in to App.net and authorizing %@ to use your App.net account,",
                                          app.appName]];
  [app println:@"return to this terminal window and enter the code from your Web browser."];
  [app print:@"Press ENTER to open a Web browser and begin the authorization process -->"];
  [app getInput];

  [app openURL:[NSString stringWithFormat:self.oauthURLFormat, self.clientID, self.redirectURI, self.scope]];

  [app println:@""];
  [app print:@"Enter code from your Web browser: "];
  NSString *accessToken = [app getInput];
  if (accessToken.length > 0) {
    app.accessToken = accessToken;
    return 0;
  } else {
    [app println:@"Error: You entered a blank code."];
    return 1;
  }
}

- (void)showHelp {
}

- (NSString *)oauthURLFormat {
  return @"https://account.app.net/oauth/authenticate?client_id=%@&response_type=token&redirect_uri=%@&scope=%@";
}

- (NSString *)clientID {
  return @"zEKkE4JBYNjnarYvEwGZxvFq7zuhEfnU";
}

- (NSString *)redirectURI {
  return @"http://grailbox.com/wry/callback";
}

- (NSString *)scope {
  return @"basic stream email write_post follow public_messages messages";
}

@end
