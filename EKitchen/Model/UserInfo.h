//
//  UserInfo.h
//  EKitchen
//
//  Created by julong on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *userId; //用户id
@property (nonatomic, copy) NSString *sessionId; //会员登陆认证标识
@property (nonatomic, copy) NSString *userType; //用户类型
@property (nonatomic, copy) NSString *userName; //会员登陆名称
@property (nonatomic, copy) NSString *picture; //头像
@property (nonatomic, copy) NSString *nickName; //会员昵称
@property (nonatomic, copy) NSString *realName; //会员真实姓名
@property (nonatomic, assign) int sex; //保密（-1）、男（0）、女（1）
@property (nonatomic, copy) NSString *birthday; //会员生日
@property (nonatomic, assign) int  age; //年龄

@end
