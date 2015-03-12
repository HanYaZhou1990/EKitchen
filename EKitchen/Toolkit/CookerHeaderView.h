//
//  CookerHeaderView.h
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CookerHeaderView;

@protocol CookerHeaderViewDelegate <NSObject>

- (void)headerView:(CookerHeaderView *)headerView clickbutton:(UIButton *)sender;

@end

@interface CookerHeaderView : UITableViewHeaderFooterView

/*!菜名*/
@property (nonatomic, strong) UILabel           *dishNameLable;
/*!区头标题*/
@property (nonatomic, strong) UILabel           *titleLable;
/*!右侧按钮的标题*/
@property (nonatomic, strong) NSString          *titleString;

/*!代理*/
@property (nonatomic, assign) id <CookerHeaderViewDelegate> delegate;

@end
