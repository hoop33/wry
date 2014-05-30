//
//  WryCommandLine.h
//  wry
//
//  Created by Rob Warner on 5/2/14.
//  Copyright (c) 2014 Rob Warner. All rights reserved.
//

@protocol WryCommand;
@protocol WryFormatter;

@interface WryCommandLine : NSObject

@property (nonatomic, copy) NSString *commandName;
@property (nonatomic, strong) NSArray *params;
@property (nonatomic, strong) NSMutableDictionary *overrides;

- (BOOL)parseString:(NSString *)commandLine error:(NSError **)error;
- (BOOL)parseParameters:(NSArray *)parameters error:(NSError **)error;
- (int)run;

@end
