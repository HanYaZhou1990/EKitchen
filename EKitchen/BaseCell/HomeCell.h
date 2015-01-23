//
//  HomeCell.h
//  EKitchen
//
//  Created by julong on 15/1/22.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

- (void)setHeadImageStr:(NSString *)headImgStr  andUseName:(NSString *)useNameStr  andScore:(float)score andImgArray:(NSString *)imageArrayStr andInfo:(NSString *)infoStr andCook:(NSString *)cookStr andUseSign:(NSString *)useSign;

@end
