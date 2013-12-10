//
//  main.m
//  wry
//
//  Created by Rob Warner on 3/8/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "WryErrorCodes.h"
#import "WrySetting.h"
#import "WryUtils.h"
#import "VersionSetting.h"

id <WrySetting> settingForFlag(NSString *flag);

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    WryApplication *application = [WryApplication application];
    application.appName = [[NSString stringWithUTF8String:argv[0]] lastPathComponent];

    NSString *errorMessage = nil;
    NSMutableArray *params = [NSMutableArray array];
    for (int i = 1; i < argc; i++) {
      NSString *param = [NSString stringWithUTF8String:argv[i]];
      if ([param hasPrefix:@"-"]) {
        id <WrySetting> setting = settingForFlag([param stringByReplacingOccurrencesOfString:@"-" withString:@""]);
        if (setting == nil) {
          errorMessage = [NSString stringWithFormat:@"Unknown flag: %@", param];
          break;
        } else {
          NSUInteger num = [setting numberOfParameters];
          i += num;
          if (i >= argc) {
            errorMessage = [NSString stringWithFormat:@"Missing parameter for %@", param];
            break;
          } else {
            [application.settings setTransientValue:[NSString stringWithUTF8String:argv[i]] forSetting:setting];
          }
        }
      } else if (application.commandName == nil) {
        application.commandName = param;
      } else {
        [params addObject:param];
      }
    }
    if (errorMessage != nil) {
      [application println:errorMessage];
      return WryErrorCodeBadInput;
    } else {
      application.params = [NSArray arrayWithArray:params];
      if (application.commandName == nil) {
        application.commandName = [application.settings boolValue:[WryUtils nameForSettingForClass:[VersionSetting class]]] ?
          @"version" : @"help";
      }
      return [application run];
    }
  }
}

id <WrySetting> settingForFlag(NSString *flag) {
  id <WrySetting> setting = nil;
  switch (flag.length) {
    case 0:
      break;
    case 1:
      setting = [WryUtils settingForShortFlag:flag];
      break;
    default:
      setting = [WryUtils settingForName:flag];
      break;
  }
  return setting;
}
