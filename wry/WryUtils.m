//
//  WryUtils.m
//  wry
//
//  Created by Rob Warner on 3/26/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <objc/objc-runtime.h>

#import "WryUtils.h"
#import "WryErrorCodes.h"
#import "ADNService.h"

#define kCommandSuffix @"Command"
#define kFormatterSuffix @"Formatter"

@interface WryUtils ()
+ (BOOL)performOperation:(WryApplication *)app
                  params:(NSArray *)params
           minimumParams:(NSInteger)minimumParams
            errorMessage:(NSString *)errorMessage
                   error:(NSError **)error
               operation:(ADNOperationBlock)operation
         outputOperation:(ADNOutputOperationBlock)outputOperation;
@end

@implementation WryUtils

+ (BOOL)performObjectOperation:(WryApplication *)app
                        params:(NSArray *)params
                 minimumParams:(NSInteger)minimumParams
                  errorMessage:(NSString *)errorMessage
                         error:(NSError **)error
                     operation:(ADNOperationBlock)operation {
  return [WryUtils performOperation:app
                             params:params
                      minimumParams:minimumParams
                       errorMessage:errorMessage
                              error:error
                          operation:operation
                    outputOperation:(ADNOutputOperationBlock) ^(ADNResponse *response) {
                      [app println:[app.formatter format:response]];
                    }];
}

+ (BOOL)performListOperation:(WryApplication *)app
                      params:(NSArray *)params
               minimumParams:(NSInteger)minimumParams
                errorMessage:(NSString *)errorMessage
                       error:(NSError **)error
                   operation:(ADNOperationBlock)operation {
  return [WryUtils performOperation:app
                             params:params
                      minimumParams:minimumParams
                       errorMessage:errorMessage
                              error:error
                          operation:operation
                    outputOperation:(ADNOutputOperationBlock) ^(ADNResponse *response) {
                      NSArray *list = (NSArray *) response.object;
                      if (list.count > 0) {
                        [app println:[app.formatter format:response]];
                      }
                    }];
}

+ (BOOL)performOperation:(WryApplication *)app
                  params:(NSArray *)params
           minimumParams:(NSInteger)minimumParams
            errorMessage:(NSString *)errorMessage
                   error:(NSError **)error
               operation:(ADNOperationBlock)operation
         outputOperation:(ADNOutputOperationBlock)outputOperation {
  BOOL success = YES;
  if (params.count < minimumParams) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    }
    success = NO;
  } else {
    ADNService *service = [[ADNService alloc] initWithAccessToken:app.accessToken];
    service.count = app.count;
    service.debug = app.debug;
    ADNResponse *response = operation(service);
    if (response != nil) {
      if (response.meta != nil) {
        NSInteger returnCode = [[response.meta valueForKey:@"code"] integerValue];
        if (returnCode == 200) {
          outputOperation(response);
        } else {
          if (error != NULL) {
            *error = [NSError errorWithDomain:app.errorDomain code:returnCode
                                     userInfo:@{NSLocalizedDescriptionKey : [response.meta valueForKey:@"error_message"]}];
          }
          success = NO;
        }
      }
    } else {
      // Service might have supplied an error; if not, supply one
      if (error != NULL && *error == nil) {
        *error = [NSError errorWithDomain:app.errorDomain
                                     code:WryErrorCodeUnknown
                                 userInfo:@{NSLocalizedDescriptionKey : @"The operation was unsuccessful"}];
      }
      success = NO;
    }
  }
  return success;
}

+ (id <WryCommand>)commandForName:(NSString *)name {
  id <WryCommand> wryCommand = nil;
  Class cls = NSClassFromString([NSString stringWithFormat:@"%@%@", [name capitalizedString], kCommandSuffix]);
  if (cls != nil && [cls conformsToProtocol:@protocol(WryCommand)]) {
    wryCommand = [[cls alloc] init];
  }
  return wryCommand;
}

+ (NSString *)nameForCommand:(id <WryCommand>)command {
  NSString *string = [[command.class description] lowercaseString];
  return [string substringToIndex:(string.length - kCommandSuffix.length)];
}

+ (NSArray *)allCommands {
  NSMutableArray *commands = [NSMutableArray array];
  Class *classes = NULL;
  int numClasses = objc_getClassList(NULL, 0);
  if (numClasses > 0) {
    classes = (__unsafe_unretained Class *) malloc(sizeof(Class) * numClasses);
    int n = objc_getClassList(classes, numClasses);
    for (int i = 0; i < n; i++) {
      Class cls = classes[i];
      NSString *className = [NSString stringWithUTF8String:class_getName(classes[i])];
      if ([className hasSuffix:kCommandSuffix] && [cls conformsToProtocol:@protocol(WryCommand)]) {
        [commands addObject:cls];
      }
    }
    free(classes);
  }
  return [commands sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    NSString *first = [(Class) a description];
    NSString *second = [(Class) b description];
    return [first compare:second];
  }];
}

+ (id <WryFormatter>)formatterForName:(NSString *)name {
  id <WryFormatter> wryFormatter = nil;
  Class cls = NSClassFromString([NSString stringWithFormat:@"%@%@", [name uppercaseString], kFormatterSuffix]);
  if (cls != nil && [cls conformsToProtocol:@protocol(WryFormatter)]) {
    wryFormatter = [[cls alloc] init];
  }
  return wryFormatter;
}

+ (NSString *)nameForFormatter:(id <WryFormatter>)formatter {
  NSString *string = [[formatter.class description] lowercaseString];
  return [string substringToIndex:(string.length - kFormatterSuffix.length)];
}

+ (NSArray *)allFormats {
  NSMutableArray *formats = [NSMutableArray array];
  Class *classes = NULL;
  int numClasses = objc_getClassList(NULL, 0);
  if (numClasses > 0) {
    classes = (__unsafe_unretained Class *) malloc(sizeof(Class) * numClasses);
    int n = objc_getClassList(classes, numClasses);
    for (int i = 0; i < n; i++) {
      Class cls = classes[i];
      NSString *className = [NSString stringWithUTF8String:class_getName(classes[i])];
      if ([className hasSuffix:kFormatterSuffix] && [cls conformsToProtocol:@protocol(WryFormatter)]) {
        [formats addObject:cls];
      }
    }
    free(classes);
  }
  return [formats sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    NSString *first = [(Class) a description];
    NSString *second = [(Class) b description];
    return [first compare:second];
  }];
}

@end
