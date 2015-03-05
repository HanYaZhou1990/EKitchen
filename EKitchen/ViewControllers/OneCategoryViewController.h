//
//  OneCategoryViewController.h
//  EKitchen
//
//  Created by hanyazhou on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "YZSegment.h"
#import "CategoryCell.h"
#import "CookerDetailViewController.h"

@interface OneCategoryViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,YZSegmentDelegate>

@property (nonatomic, strong) NSString          *categoryString;

@end
