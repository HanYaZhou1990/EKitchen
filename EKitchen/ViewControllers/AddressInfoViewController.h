//
//  AddressInfoViewController.h
//  EKitchen
//
//  Created by julong on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressInfo.h"

@interface AddressInfoViewController : BaseViewController

@property (nonatomic,strong) NSString *typeStr; //0 新增 1编辑
@property (nonatomic,strong) AddressInfo *_addressInfo; //0 新增 1编辑


@end
