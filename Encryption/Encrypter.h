//
//  Encrypter.h
//  del
//
//  Created by Rishabh Tayal on 10/7/13.
//  Copyright (c) 2013 Rishabh Tayal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encrypter : NSObject

+(NSData*)encryptData:(NSData*)data key:(NSString *)key initVec:(NSString *)initVec;

@end
