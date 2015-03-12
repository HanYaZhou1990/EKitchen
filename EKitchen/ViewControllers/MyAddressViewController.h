//
//  MyAddressViewController.h
//  EKitchen
//
//  Created by julong on 15/1/21.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"

@class MyAddressViewController;

@protocol MyAddressViewControllerDelegate <NSObject>

- (void)viewController:(MyAddressViewController *)viewController address:(NSString *)addressString;

@end

@interface MyAddressViewController : BaseViewController

@property (nonatomic, assign) id <MyAddressViewControllerDelegate> delegate;

@property (nonatomic,strong) NSString *typeStr; //1选择列表 其他查看列表 

@end
