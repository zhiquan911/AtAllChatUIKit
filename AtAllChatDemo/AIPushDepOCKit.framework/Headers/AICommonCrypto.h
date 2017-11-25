//
//  AICommonCrypto.h
//  AIPush
//
//  Created by Chance on 2017/9/7.
//  Copyright © 2017年 blocktree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AICommonCrypto : NSObject


/**
 sha256 hash

 @param string 要hash的字符串
 @return hash值
 */
+ (nonnull NSString *)sha256:(nonnull NSString *)string;


/**
 MD5 hash

 @param string 要hash的字符串
 @return hash值
 */
+ (nonnull NSString *)md5:(nonnull NSString *)string;

/**
HmacSHA1加密
 
 @param string 要加密的字符串
 @param key 要加密的key
 @return HmacSHA1加密值
 */
+(nonnull NSString *)HmacSha1:(nonnull NSString *)string key:(nonnull NSString *)key;

@end
