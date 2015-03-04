//
//  CategoryCell.h
//  EKitchen
//
//  Created by hanyazhou on 15/3/4.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculationTool.h"

/*用户级别*/
typedef enum {
    /*!初级、中级、高级*/
    CategoryCellLevelTypePrimary,
    CategoryCellLevelTypeIntermediate,
    CategoryCellLevelTypeAdvanced,
}CategoryCellLevelType;

/*用户类型*/
typedef enum {
    /*!个人、团队、企业*/
    CategoryCellUserTypePersonal,
    CategoryCellUserTypeTeam,
    CategoryCellUserTypeEnterprise,
}CategoryCellUserType;

@interface CategoryCell : UITableViewCell

/*!前边的图片*/
@property (nonatomic, strong) UIImage    *hederImage;
/*!用户名*/
@property (nonatomic, strong) NSString   *userNameString;
/*用户级别*/
@property (nonatomic, assign) CategoryCellLevelType  levelType;
/*!Fraction 分数*/
@property (nonatomic, strong) NSString   *fractionString;
/*!Distance 距离*/
@property (nonatomic, strong) NSString   *distanceString;
/*用户类型*/
@property (nonatomic, assign) CategoryCellUserType    userType;

@end
