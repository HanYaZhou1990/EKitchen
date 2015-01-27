//
//  OrderCell.h
//  EKitchen
//
//  Created by julong on 15/1/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderCellDelegate <NSObject>

-(void)payBtnClicked:(id)sender;
-(void)commentBtnClicked:(id)sender;

@end

@interface OrderCell : UITableViewCell
{
    id<OrderCellDelegate> orderDelegate;
}

@property (nonatomic,assign,setter = setDelegate:) id<OrderCellDelegate> orderDelegate;

- (void)setHeadImageStr:(NSString *)headImageStr andUseNameStr:(NSString *)useNameStr  andPackageTypeStr:(NSString *)packageTypeStr  andOrderTimeStr:(NSString *)orderTimeStr andOrderTypeStr:(NSString *)orderTypeStr andOrderAddressStr:(NSString *)orderAddressStr andOrderMoneyStr:(NSString *)orderMoneyStr andRow:(NSInteger)row;

@end
