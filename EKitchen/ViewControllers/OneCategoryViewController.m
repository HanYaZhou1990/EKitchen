//
//  OneCategoryViewController.m
//  EKitchen
//
//  Created by hanyazhou on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "OneCategoryViewController.h"

@interface OneCategoryViewController ()
{
    YZSegment                  *__segment;
    UITableView                *__categoryTableView;
    NSArray                    *__listArray;
}
@end

@implementation OneCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *itemTitleArray = @[@"等级优先",@"评分最好",@"离我最近"];
    __segment = [[YZSegment alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44) btnInformation:itemTitleArray contentOffSet:0];
    __segment.myDelegate = self;
    
    __categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
    __categoryTableView.dataSource = self;
    __categoryTableView.delegate = self;
    [__categoryTableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"cell"];
    __categoryTableView.tableFooterView = [UIView new];
    [self.view addSubview:__categoryTableView];
    
    __listArray = @[@"粤菜",@"鲁菜",@"川菜",@"湘菜",@"闵菜",@"浙菜",@"苏菜",@"徽菜"];
}

#pragma mark - YZSegmentDelegate
- (void)view:(UIScrollView *)view didSelectIndex:(NSInteger)indexOfButton{
    switch (indexOfButton) {
        case 0:
        {
        __listArray = @[@"粤菜",@"鲁菜",@"川菜",@"湘菜",@"闵菜",@"浙菜",@"苏菜",@"徽菜"];
        [__categoryTableView reloadData];
        }
            break;
        case 1:
        {
        __listArray = @[@"法国菜",@"英国菜",@"美国菜",@"俄国菜",@"德国菜",@"意大利菜",@"日本料理",@"东南亚菜",@"美式快餐",@"瑞士菜",@"西班牙菜",@"其它西餐"];
        [__categoryTableView reloadData];
        }
            break;
        case 2:
        {
        __listArray = @[@"小葱拌豆腐"];
        [__categoryTableView reloadData];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return __listArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return __segment;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.hederImage = [UIImage imageNamed:@"meBackground.png"];
    cell.userNameString = @"韩亚周";
    if (indexPath.row == 1) {
        cell.userType = CategoryCellUserTypeTeam;
        cell.levelType = CategoryCellLevelTypeIntermediate;
        cell.fractionString = @"9.7分";
    }else if (indexPath.row == 2){
        cell.levelType = CategoryCellLevelTypeAdvanced;
        cell.fractionString = @"10分";
    }else {
        cell.fractionString = @"0.1分";
    }
    cell.distanceString = @"10000km";
    cell.specialtyArray = @[@"湘菜",@"豫菜",@"淮南菜"];
    cell.introductionString = @"公路喜剧最近几年在国内属于现象级题材，随着《人在囧途》、《泰囧》、《心花路放》等片";
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CookerDetailViewController *cookerViewController = [[CookerDetailViewController alloc] init];
    [self.navigationController pushViewController:cookerViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
