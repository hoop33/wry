//
//  TextTooLongEnhancer.h
//  wry
//
//  Created by Rob Warner on 6/27/13.
//  Copyright (c) 2013 Rob Warner. All rights reserved.
//

#import "WryEnhancer.h"

#define kMaxTextLength 256

typedef enum {
  TextTooLongOptionAsk = 0,
  TextTooLongOptionReject,
  TextTooLongOptionTruncate,
  TextTooLongOptionSplit
} TextTooLongOption;

@interface TextTooLongEnhancer : NSObject <WryEnhancer>

@end
