//
//  BaseCommandAbstract.m
//  wry
//
//  Created by Rob Warner on 9/7/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryCommand.h"
#import "BaseCommandAbstract.h"
#import "WryUtils.h"
#import "WryErrorCodes.h"

@implementation BaseCommandAbstract

- (NSString *)description {
  return [NSString stringWithFormat:@"   %-12s%@", [[WryUtils nameForCommand:self] UTF8String], [self summary]];
}

- (NSString *)usage {
  return nil;
}

- (NSString *)summary {
  return nil;
}

- (NSString *)help {
  return nil;
}

- (BOOL)run:(NSArray *)params formatter:(id <WryFormatter>)formatter options:(NSDictionary *)options error:(NSError **)error {
  return WryErrorCodeUnknown;
}

@end
