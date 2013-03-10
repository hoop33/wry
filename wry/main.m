//
//  main.m
//  wry
//
//  Created by Rob Warner on 3/8/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WryApplication.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool {
    WryApplication *application = [[WryApplication alloc] init];
    application.command = argc == 1 ? nil : [NSString stringWithUTF8String:argv[1]];
    NSMutableArray *params = [NSMutableArray array];
    for (int i = 2; i < argc - 1; i++)
    {
      [params addObject:[NSString stringWithUTF8String:argv[i]]];
    }
    application.params = [NSArray arrayWithArray:params];
    return [application run];
  }
}
