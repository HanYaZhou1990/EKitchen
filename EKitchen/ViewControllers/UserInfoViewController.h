//
//  UserInfoViewController.h
//  EKitchen
//
//  Created by julong on 15/1/23.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    UserInfoViewControllerTypeMember,
    UserInfoViewControllerTypeCooker,
}UserInfoViewControllerType;

@interface UserInfoViewController : BaseViewController

/*用户类型*/
@property (nonatomic, assign) UserInfoViewControllerType   userType;
/*传过来用户信息*/
@property (nonatomic,strong ) NSDictionary    *userInfoDic;

@end
