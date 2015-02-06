//
//  YYDes.h
//  YYDes
//
//  Created by hanyazhou on 15/2/6.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "GTMBase64.h"

@interface YYDes : NSObject
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSString *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;
/******************************************************************************
 函数名称 : + (NSString *)DESDecryptString:(NSString *)desString WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSString *)desString
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSString *)DESDecryptString:(NSString *)desString WithKey:(NSString *)key;
/******************************************************************************
 函数名称 : + (NSString*)SHA1:(NSString *)string
 函数描述 : 文本数据进行SHA-1加密
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSString*)SHA1:(NSString *)string;
/******************************************************************************
 函数名称 : + (NSString *)generate:(NSDictionary *)parameters
 函数描述 : 将字典按照顺序排列，然后转成拼接成一个字符串，加入特殊签名并经过SHA-1加密
 输入参数 : (NSDictionary *)parameters;
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSString *)generate:(NSDictionary *)parameters;

@end
