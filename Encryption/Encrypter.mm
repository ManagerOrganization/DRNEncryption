//
//  Encrypter.m
//  del
//
//  Created by Rishabh Tayal on 10/7/13.
//  Copyright (c) 2013 Rishabh Tayal. All rights reserved.
//

#import "Encrypter.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+NSStringAdditions.h"

@implementation Encrypter

+(NSData*)newEncryptData:(NSData*)data key:(NSString*)key initVec:(NSString*)initVec {
    const void *vKey =  [[NSString base64DataFromString:key] bytes];
    const void * vInitVec = [[NSString base64DataFromString:initVec] bytes];
    
    //    NSData* data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataLength = [data length];
    int diff = kCCKeySize3DES - (dataLength % kCCKeySize3DES);
    size_t newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    //    DLog(@"%@", [NSData dataWithBytes:dataPtr length:sizeof(dataPtr)]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    //    DLog(@"%@", [NSData dataWithBytes:dataPtr length:sizeof(dataPtr)]);
    size_t bufferSize = newSize + kCCBlockSize3DES;
    void *buffer = malloc(bufferSize);
    
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithm3DES,
                                          0x0000, //No padding
                                          vKey,
                                          kCCKeySize3DES,
                                          vInitVec,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess)
    {
        NSData* result = [NSData dataWithBytes:(const void*)buffer length:(NSUInteger)numBytesEncrypted];
        return result;
    }
    
    return nil;
}

+(NSData*)newDecryptData:(NSData*)data key:(NSString *)key initVec:(NSString *)initVec{
    const void *vKey =  [[NSString base64DataFromString:key] bytes];
    const void * vInitVec = [[NSString base64DataFromString:initVec] bytes];
    
    //    NSData* data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataLength = [data length];
    int diff = kCCKeySize3DES - (dataLength % kCCKeySize3DES);
    size_t newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    //    DLog(@"%@", [NSData dataWithBytes:dataPtr length:sizeof(dataPtr)]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    //    DLog(@"%@", [NSData dataWithBytes:dataPtr length:sizeof(dataPtr)]);
    size_t bufferSize = newSize + kCCBlockSize3DES;
    void *buffer = malloc(bufferSize);
    
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithm3DES,
                                          0x0000, //No padding
                                          vKey,
                                          kCCKeySize3DES,
                                          vInitVec,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess)
    {
        NSData* result = [NSData dataWithBytes:(const void*)buffer length:(NSUInteger)numBytesEncrypted];
        return result;
        //        return [NSString base64StringFromData:result length:(int)result.length];
    }
    
    return nil;
}

@end
