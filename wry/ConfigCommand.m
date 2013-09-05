//
//  ConfigCommand.m
//  wry
//
//  Created by Rob Warner on 8/23/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ConfigCommand.h"
#import "WrySetting.h"
#import "WryUtils.h"
#import "WryErrorCodes.h"
#import "WrySettings.h"

@implementation ConfigCommand

- (BOOL)run:(NSArray *)params error:(NSError **)error {
  BOOL success = YES;
  WryApplication *app = [WryApplication application];
  if (params.count == 0) {
    for (Class cls in [WryUtils allSettings]) {
      NSString *name = [WryUtils nameForSettingForClass:cls];
      NSString *value = [app.settings stringValue:name];
      if (value == nil) {
        value = @"*none*";
      }
      [app println:[NSString stringWithFormat:@"%15s : %@", [name UTF8String], value]];
    }
  } else {
    id <WrySetting> setting = [WryUtils settingForName:params[0]];
    if (setting == nil) {
      if (error != NULL) {
        *error = [NSError errorWithDomain:app.errorDomain
                                     code:WryErrorCodeBadInput userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Setting '%@' does not exist", params[0]]}];
      }
      success = NO;
    } else {
      if (params.count == 1) {
        // Print the current value
        [app println:[NSString stringWithFormat:@"%@ : %@", params[0], [app.settings stringValue:params[0]]]];
      } else {
        [app.settings setObject:params[1] forKey:params[0]];
      }
    }
  }
  return success;
}

- (NSString *)usage {
  return @"<setting name> [setting value]";
}

- (NSString *)help {
  NSMutableString *help = [[NSMutableString alloc] init];
  [help appendFormat:@"Sets a configuration value in the %@ preferences file.\n", [[WryApplication application] appName]];
  [help appendString:@"You must pass a setting name and an optional value. If you leave the value blank,\n"
    @"the configured setting will be displayed from the preferences file. The settings and allowed values are:\n\n"];
    for (Class cls in [WryUtils allSettings]) {
      id <WrySetting> setting = [[cls alloc] init];
      [help appendFormat:@"   %-17s: %@\n", [[WryUtils nameForSetting:setting] UTF8String], [[setting allowedValues] componentsJoinedByString:@", "]];
    }
  return help;
}

- (NSString *)summary {
  return @"Configure a setting in your preferences";
}

@end
