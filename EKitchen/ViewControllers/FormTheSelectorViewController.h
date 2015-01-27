//
//  FormTheSelectorViewController.h
//  KH_MobileShop
//
//  Created by yons on 13-12-24.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
//定义协议名称及方法
@protocol FormTheSelectorViewControllerDelegate
-(void)formTheSelectorMessage:(id)sender;
@end


@interface FormTheSelectorViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSString *titleStr;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray     *dataSource;

@property (nonatomic, strong) NSIndexPath * lastIndexPath;

//声明代理名称
@property (nonatomic,assign) id<FormTheSelectorViewControllerDelegate> formTheSelectorVCdelegate;

@end
