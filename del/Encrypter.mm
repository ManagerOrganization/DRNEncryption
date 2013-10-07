//
//  Encrypter.m
//  del
//
//  Created by Rishabh Tayal on 10/7/13.
//  Copyright (c) 2013 Rishabh Tayal. All rights reserved.
//

#import "Encrypter.h"
#import "CkoCrypt2.h"

@implementation Encrypter

+(NSData*)encryptData:(NSData*)data key:(NSString *)key initVec:(NSString *)initVec {
    NSLog(@"Encrypt");
    
    NSMutableString *strOutput = [NSMutableString stringWithCapacity:1000];
    
    CkoCrypt2 *crypt = [[CkoCrypt2 alloc] init];
    
    BOOL success;
    success = [crypt UnlockComponent: @"JAMESDCrypt_pK4AHbGrZRnG"];
    if (success != YES) {
        [strOutput appendString: crypt.LastErrorText];
        [strOutput appendString: @"\n"];
        //        return strOutput;
    }
    
    //  Specify 3DES for the encryption algorithm:
    crypt.CryptAlgorithm = @"3des";
    
    //  CipherMode may be "ecb" or "cbc"
    crypt.CipherMode = @"cbc";
    
    //  KeyLength must be 192.  3DES is technically 168-bits;
    //  the most-significant bit of each key byte is a parity bit,
    //  so we must indicate a KeyLength of 192, which includes
    //  the parity bits.
    crypt.KeyLength = [NSNumber numberWithInt:192];
    
    //  The padding scheme determines the contents of the bytes
    //  that are added to pad the result to a multiple of the
    //  encryption algorithm's block size.  3DES has a block
    //  size of 8 bytes, so encrypted output is always
    //  a multiple of 8.
    crypt.PaddingScheme = [NSNumber numberWithInt:3];
    
    //  EncodingMode specifies the encoding of the output for
    //  encryption, and the input for decryption.
    //  It may be "hex", "url", "base64", or "quoted-printable".
    crypt.EncodingMode = @"base64";
    
    //  An initialization vector is required if using CBC or CFB modes.
    //  ECB mode does not use an IV.
    //  The length of the IV is equal to the algorithm's block size.
    //  It is NOT equal to the length of the key.
    [crypt SetEncodedIV: initVec encoding: @"base64"];
    
    //  The secret key must equal the size of the key.  For
    //  3DES, the key must be 24 bytes (i.e. 192-bits).
    [crypt SetEncodedKey: key encoding: @"base64"];
    
    //  Encrypt a string...
    //  The input string is 44 ANSI characters (i.e. 44 bytes), so
    //  the output should be 48 bytes (a multiple of 8).
    //  Because the output is a hex string, it should
    //  be 96 characters long (2 chars per byte).
    //    NSLog(@"%@",crypt.LastErrorText);
    
    NSMutableData *encStr = [[NSMutableData alloc] initWithData:[crypt EncryptBytes:data]];
    
    //TODO: Remove the hardcoded encrypted string after purchasing library license.
    //    encStr = @"X2igGNpj/MI2LhU8JtpRSw==";//Encryption string for password dls1974.k
    //    encStr = @"X2igGNpj/MKzK5id73gcTA==";//Encryption string for password dls1974.j
    //    [strOutput appendString: encStr];
    //    [strOutput appendString: @"\n"];
    //    NSLog(@"%@",[[NSString alloc] initWithData:encStr encoding:n]);
    return encStr;

}

@end
