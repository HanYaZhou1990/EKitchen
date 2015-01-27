//
//  SearchViewController.h
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "RecommendCell.h"
#import "OneCategoryViewController.h"

@interface SearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,RecommendCellDelegate>

@property (nonatomic, strong) UITableView     *searchTableView;

@end
