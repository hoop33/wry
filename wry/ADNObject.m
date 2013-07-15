//
//  ADNObject.m
//  wry
//
//  Created by Rob Warner on 6/25/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNObject.h"
#import "WryApplication.h"
#import "WrySettings.h"

NSString * const TagColorStart = @"\x1b[";
NSString * const TagColorEnd = @"\x1b[0m";

@implementation ADNObject

- (NSString *)colorDescription {
  return [self description];
}

- (NSString *)colorize:(NSString *)text colorSetting:(NSString *)settingName {
  return [NSString stringWithFormat:@"%@%@%@%@",
    TagColorStart,
    [[WryApplication application].settings stringValue:settingName],
    text,
    TagColorEnd
  ];
}

@end
