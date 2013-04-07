//
//  WryFormatter.h
//  wry
//
//  Created by Rob Warner on 4/6/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNResponse.h"

@protocol WryFormatter <NSObject>

- (NSString *)format:(ADNResponse *)response;
- (NSString *)summary;

@end
