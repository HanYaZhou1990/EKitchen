//
//  CookerTimeCell.h
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

/*用于展示厨师详细页的厨师的工作时间和常驻地址*/
@interface CookerTimeCell : UITableViewCell
/*!厨师工作日*/
@property (nonatomic, strong) NSArray   *workDayArray;
/*!厨师地址*/
@property (nonatomic, strong) NSString  *addressString;
@end
