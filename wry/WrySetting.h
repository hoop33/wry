//
//  WrySetting.h
//  wry
//
//  Created by Rob Warner on 7/31/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

typedef NS_ENUM(NSInteger, WrySettingType) {
  WrySettingUnknownType,
  WrySettingBooleanType,
  WrySettingIntegerType,
  WrySettingStringType
} ;

@protocol WrySetting <NSObject>

- (NSString *)shortFlag;
- (NSString *)summary;
- (NSString *)help;
- (NSUInteger)numberOfParameters;
- (NSArray *)allowedValues;
- (WrySettingType)type;

@end
