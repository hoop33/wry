//
//  ADNAnnotation.h
//  wry
//
//  Created by Rob Warner on 5/13/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "ADNObject.h"

@interface ADNAnnotation : ADNObject

@property(nonatomic, copy) NSString *type;
@property(nonatomic, strong) NSDictionary *value;

@end
