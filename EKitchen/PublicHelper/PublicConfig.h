//
//  MXSHelper.h
//  xuexin
//
//  Created by renbing on 8/19/13.
//  Copyright (c) 2013 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicConfig : NSObject

+ (void)setValue:(id)value forKey:(NSString *)key;//为特定key指定value

+ (id)valueForKey:(NSString *)key;//从特定key取得value

//去除空格，回车换行、换行
+ (NSString *)removeSpaceChangeLine:(NSString *)textString;

//字典转化为字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

//字符串转化为字典
+ (NSDictionary *)jsonToDictionary:(NSString *)str;

//字典转化为get请求字符串
+ (NSString *)serializeToUrlByDicString:(NSDictionary *)dic;

//提示框
+ (void)waringInfo:(NSString *)msgInfo;

//判断字符串为空 插入替代字符串
+ (NSString *)isSpaceString:(NSString *)firstStr andReplace:(NSString *)replaceStr;

//去掉ios7下被导航栏遮挡UIView得问题;
+(void)removerCoverView:(UIViewController*)viewController;

//设置返回键左边距
+(UIBarButtonItem *)setLeftBarBtnSpaceWidth;

//计算字符串宽度
+ (CGFloat)width:(NSString *)contentString heightOfFatherView:(CGFloat)height textFont:(UIFont *)font;
//计算字符串高度
+ (CGFloat)height:(NSString *)contentString widthOfFatherView:(CGFloat)width textFont:(UIFont *)font;
//计算左边返回按钮的宽度
+(CGFloat)leftBtnWidth:(NSString *)contentString maxOfWidth:(CGFloat)maxWidth;

@end

