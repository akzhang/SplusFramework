//
//  AES128Util.h
//  YayawanIOS
//
//  Created by andsky on 14-4-15.
//  Copyright (c) 2014年 akzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128Util : NSObject
+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;

+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;
@end
