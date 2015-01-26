//
//  CategoryViewController.h
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "YZSegment.h"
#import "OneCategoryViewController.h"

@interface CategoryViewController : BaseViewController<YZSegmentDelegate,UITableViewDataSource,UITableViewDelegate>

@end
