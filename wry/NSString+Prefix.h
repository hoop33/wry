//
//  NSString+Prefix.h
//  wry
//
//  Created by Rob Warner on 5/1/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Prefix)

- (NSString *)atify;
- (NSString *)deatify;
- (NSString *)hashtagify;
- (NSString *)dehashtagify;

@end
