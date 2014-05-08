//
//  WrySetting.h
//  wry
//
//  Created by Rob Warner on 7/31/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

typedef enum {
  WrySettingUnknownType,
  WrySettingBooleanType,
  WrySettingIntegerType,
  WrySettingStringType
} WrySettingType;

@protocol WrySetting <NSObject>

- (NSString *)shortFlag;
- (NSString *)summary;
- (NSString *)help;
- (NSUInteger)numberOfParameters;
- (NSArray *)allowedValues;
- (WrySettingType)type;

@end
