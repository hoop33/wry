//
//  main.m
//  wry
//
//  Created by Rob Warner on 3/8/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryApplication.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool {
    WryApplication *application = [[WryApplication alloc] init];
    application.appName = [[NSString stringWithUTF8String:argv[0]] lastPathComponent];
    application.command = argc == 1 ? nil : [NSString stringWithUTF8String:argv[1]];
    NSMutableArray *params = [NSMutableArray array];
    for (int i = 2; i < argc - 1; i++)
    {
      NSString *param = [NSString stringWithUTF8String:argv[i]];
      if ([param isEqualToString:@"-q"] || [param isEqualToString:@"--quiet"])
      {
        application.quiet = YES;
      }
      else
      {
        [params addObject:param];
      }
    }
    application.params = [NSArray arrayWithArray:params];
    return [application run];
  }
}
