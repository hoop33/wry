//
//  AboutCommand.m
//  wry
//
//  Created by Rob Warner on 3/10/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "AboutCommand.h"

@implementation AboutCommand

- (int)run:(NSArray *)params
{
  printf("About!");
  return 0;
}

@end
