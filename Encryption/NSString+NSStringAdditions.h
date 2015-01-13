//
//  NSString+NSStringAdditions.h
//  WM Sales
//
//  Created by Rishabh Tayal on 9/13/12.
//  Copyright (c) 2012 Rishabh Tayal. All rights reserved.
//

#import <Foundation/NSString.h>

@interface NSString (NSStringAdditions)

+ (NSString *) base64StringFromData:(NSData *)data length:(int)length;
+ (NSData *) base64DataFromString:(NSString *)string;

@end
