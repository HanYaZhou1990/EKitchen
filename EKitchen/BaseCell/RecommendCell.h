//
//  RecommendCell.h
//  EKitchen
//
//  Created by hanyazhou on 15/1/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
/*!用于搜索页面的第一个区*/

@class RecommendCell;

@protocol RecommendCellDelegate <NSObject>

- (void)tableViewcell:(RecommendCell *)cell itemClick:(MenuView *)view itemIndex:(NSInteger)index;

@end
@interface RecommendCell : UITableViewCell<MenuViewDelegate>

/*!cell上边需要展示的按钮个数*/
@property (nonatomic, strong) NSArray                      *itemArray;
/*!代理*/
@property (nonatomic, assign) id<RecommendCellDelegate>    cellDelegate;
@end
