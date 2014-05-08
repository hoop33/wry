//
//  BaseSettingAbstract.m
//  wry
//
//  Created by Rob Warner on 9/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "BaseSettingAbstract.h"
#import "WryUtils.h"

@implementation BaseSettingAbstract

- (NSString *)shortFlag {
  return nil;
}

- (NSString *)summary {
  return nil;
}

- (NSString *)help {
  return nil;
}

- (NSUInteger)numberOfParameters {
  return 0;
}

- (NSArray *)allowedValues {
  return nil;
}

- (WrySettingType)type {
  return WrySettingBooleanType;
}

- (NSString *)description {
  if ([self conformsToProtocol:@protocol(WrySetting)]) {
    id <WrySetting> this = (id <WrySetting>) self;
    NSString *name = [WryUtils nameForSetting:this];
    if ([this numberOfParameters] == 1) {
      name = [name stringByAppendingFormat:@" <%@>", name];
    }
    return [NSString stringWithFormat:@"   -%@, --%-21s %@", [this shortFlag], [name UTF8String], [this summary]];
  } else {
    return [super description];
  }
}


@end
