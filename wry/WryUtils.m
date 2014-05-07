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
#import "CountSetting.h"
#import "DebugSetting.h"
#import "PrettySetting.h"
#import "ReverseSetting.h"
#import "AnnotationsSetting.h"
#import "BeforeSetting.h"
#import "AfterSetting.h"

#define kCommandSuffix @"Command"
#define kFormatterSuffix @"Formatter"
#define kSettingSuffix @"Setting"

@implementation WryUtils

static NSArray *allClasses;

+ (void)initialize {
  NSMutableArray *array = [NSMutableArray array];
  Class *classes = NULL;
  int numClasses = objc_getClassList(NULL, 0);
  if (numClasses > 0) {
    classes = (__unsafe_unretained Class *) malloc(sizeof(Class) * numClasses);
    int n = objc_getClassList(classes, numClasses);
    for (int i = 0; i < n; i++) {
      Class cls = classes[i];
      NSString *className = [NSString stringWithUTF8String:class_getName(cls)];
      if (([className hasSuffix:kCommandSuffix] ||
        [className hasSuffix:kFormatterSuffix] ||
        [className hasSuffix:kSettingSuffix]) &&
        ([cls conformsToProtocol:@protocol(WryCommand)] ||
          [cls conformsToProtocol:@protocol(WryFormatter)] ||
          [cls conformsToProtocol:@protocol(WrySetting)])) {
        [array addObject:cls];
      }
    }
    free(classes);
  }
  allClasses = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
    NSString *first = [(Class) a description];
    NSString *second = [(Class) b description];
    return [first compare:second];
  }];
}

+ (BOOL)getADNResponseForOperation:(NSString *)accessToken
                            params:(NSArray *)params
                     minimumParams:(NSInteger)minimumParams
                      errorMessage:(NSString *)errorMessage
                             error:(NSError **)error
                          response:(ADNResponse **)adnResponse
                         operation:(ADNOperationBlock)operation {
  return [WryUtils performOperation:accessToken
                             params:params
                      minimumParams:minimumParams
                       errorMessage:errorMessage
                            options:nil
                              error:error
                          operation:operation
                    outputOperation:(ADNOutputOperationBlock) ^(ADNResponse *response) {
                      if (response != nil) {
                        *adnResponse = response;
                      }
                    }];
}

+ (BOOL)performObjectOperation:(NSArray *)params
                 minimumParams:(NSInteger)minimumParams
                  errorMessage:(NSString *)errorMessage
                     formatter:(id <WryFormatter>)formatter
                       options:(NSDictionary *)options
                         error:(NSError **)error
                     operation:(ADNOperationBlock)operation {
  return [WryUtils performOperation:nil
                             params:params
                      minimumParams:minimumParams
                       errorMessage:errorMessage
                            options:options
                              error:error
                          operation:operation
                    outputOperation:(ADNOutputOperationBlock) ^(ADNResponse *response) {
                      WryApplication *app = [WryApplication application];
                      [app println:[formatter format:response]];
                    }];
}

+ (BOOL)performListOperation:(NSArray *)params
               minimumParams:(NSInteger)minimumParams
                errorMessage:(NSString *)errorMessage
                   formatter:(id <WryFormatter>)formatter
                     options:(NSDictionary *)options
                       error:(NSError **)error
                   operation:(ADNOperationBlock)operation {
  return [WryUtils performOperation:nil
                             params:params
                      minimumParams:minimumParams
                       errorMessage:errorMessage
                            options:options
                              error:error
                          operation:operation
                    outputOperation:(ADNOutputOperationBlock) ^(ADNResponse *response) {
                      NSArray *list = (NSArray *) response.object;
                      if (list.count > 0) {
                        WryApplication *app = [WryApplication application];
                        [app println:[formatter format:response]];
                      }
                    }];
}

+ (BOOL)performOperation:(NSString *)accessToken
                  params:(NSArray *)params
           minimumParams:(NSInteger)minimumParams
            errorMessage:(NSString *)errorMessage
                 options:options
                   error:(NSError **)error
               operation:(ADNOperationBlock)operation
         outputOperation:(ADNOutputOperationBlock)outputOperation {
  BOOL success = YES;
  WryApplication *app = [WryApplication application];
  if (params.count < minimumParams) {
    if (error != NULL) {
      *error = [NSError errorWithDomain:app.errorDomain
                                   code:WryErrorCodeBadInput userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    }
    success = NO;
  } else {
    ADNService *service = [[ADNService alloc] initWithAccessToken:(accessToken == nil ? app.accessToken : accessToken)];
    service.count = [options[[WryUtils nameForSettingForClass:[CountSetting class]]] integerValue];
    service.debug = [options[[WryUtils nameForSettingForClass:[DebugSetting class]]] boolValue];
    service.pretty = [options[[WryUtils nameForSettingForClass:[PrettySetting class]]] boolValue];
    service.reverse = [options[[WryUtils nameForSettingForClass:[ReverseSetting class]]] boolValue];
    service.annotations = [options[[WryUtils nameForSettingForClass:[AnnotationsSetting class]]] boolValue];
    service.beforeId = [options[[WryUtils nameForSettingForClass:[BeforeSetting class]]] stringValue];
    service.sinceId = [options[[WryUtils nameForSettingForClass:[AfterSetting class]]] stringValue];

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
  return [WryUtils instanceForName:[name capitalizedString] suffix:kCommandSuffix protocol:@protocol(WryCommand)];
}

+ (id <WryFormatter>)formatterForName:(NSString *)name {
  return [WryUtils instanceForName:[name uppercaseString] suffix:kFormatterSuffix protocol:@protocol(WryFormatter)];
}

+ (id <WrySetting>)settingForName:(NSString *)name {
  return [WryUtils instanceForName:[name capitalizedString] suffix:kSettingSuffix protocol:@protocol(WrySetting)];
}

+ (id <WrySetting>)settingForShortFlag:(NSString *)shortFlag {
  id <WrySetting> setting = nil;
  for (Class cls in [WryUtils allSettings]) {
    id <WrySetting> tempSetting = [[cls alloc] init];
    if ([[tempSetting shortFlag] isEqualToString:shortFlag]) {
      setting = tempSetting;
      break;
    }
  }
  return setting;
}

+ (NSString *)nameForCommand:(id <WryCommand>)command {
  return [WryUtils nameForInstance:(NSObject *) command suffix:kCommandSuffix];
}

+ (NSString *)nameForFormatter:(id <WryFormatter>)formatter {
  return [WryUtils nameForInstance:(NSObject *) formatter suffix:kFormatterSuffix];
}

+ (NSString *)nameForSetting:(id <WrySetting>)setting {
  return [WryUtils nameForInstance:(NSObject *) setting suffix:kSettingSuffix];
}

+ (NSString *)nameForSettingForClass:(Class)cls {
  return [WryUtils nameForClass:cls suffix:kSettingSuffix];
}

+ (NSArray *)allCommands {
  return [WryUtils allClassesWithSuffix:kCommandSuffix protocol:@protocol(WryCommand)];
}

+ (NSArray *)allFormatters {
  return [WryUtils allClassesWithSuffix:kFormatterSuffix protocol:@protocol(WryFormatter)];
}

+ (NSArray *)allSettings {
  return [WryUtils allClassesWithSuffix:kSettingSuffix protocol:@protocol(WrySetting)];
}

#pragma mark - Private methods

+ (id)instanceForName:(NSString *)name suffix:(NSString *)suffix protocol:(id)protocol {
  Class cls = NSClassFromString([NSString stringWithFormat:@"%@%@", name, suffix]);
  return (cls != nil && [cls conformsToProtocol:protocol]) ? [[cls alloc] init] : nil;
}

+ (NSString *)nameForInstance:(NSObject *)instance suffix:(NSString *)suffix {
  return [WryUtils nameForClass:[instance class] suffix:suffix];
}

+ (NSString *)nameForClass:(Class)cls suffix:(NSString *)suffix {
  NSString *string = [[cls description] lowercaseString];
  return [string substringToIndex:(string.length - suffix.length)];
}

+ (NSArray *)allClassesWithSuffix:(NSString *)suffix protocol:(id)protocol {
  // TODO can we use an NSPredicate here? Not sure how that would work with class_getName....
  NSMutableArray *array = [NSMutableArray array];
  for (Class cls in allClasses) {
    NSString *className = [NSString stringWithUTF8String:class_getName(cls)];
    if ([className hasSuffix:suffix] && [cls conformsToProtocol:protocol]) {
      [array addObject:cls];
    }
  }
  return array;
}

@end
