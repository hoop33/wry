//
//  main.m
//  wry
//
//  Created by Rob Warner on 3/8/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"
#import "WryErrorCodes.h"

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    WryApplication *application = [WryApplication application];
    application.appName = [[NSString stringWithUTF8String:argv[0]] lastPathComponent];
    NSMutableArray *commandLineParameters = [NSMutableArray arrayWithCapacity:(NSUInteger)argc];
    for (int i = 1; i < argc; i++) {
      [commandLineParameters addObject:[NSString stringWithUTF8String:argv[i]]];
    }
    if ([application parseCommandLine:commandLineParameters]) {
      return [application run];
    } else {
      return WryErrorCodeBadInput;
    }
  }
}
