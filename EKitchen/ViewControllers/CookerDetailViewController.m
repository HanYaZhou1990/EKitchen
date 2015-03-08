//
//  CookerDetailViewController.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CookerDetailViewController.h"

@interface CookerDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView     *_detailTableView;
    ExpandHeader    *_headerView;
    NSArray         *_workTimeArray;
}

@end

@implementation CookerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    _detailTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    [_detailTableView registerClass:[CookerHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [_detailTableView registerClass:[OpenHeaderView class] forHeaderFooterViewReuseIdentifier:@"openHeader"];
    [_detailTableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"cell"];
    [_detailTableView registerClass:[CookerTimeCell class] forCellReuseIdentifier:@"CookerTimeCell"];
    [self.view addSubview:_detailTableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    [imageView setImage:[UIImage imageNamed:@"meBackground.png"]];
    
    _headerView = [ExpandHeader expandWithScrollView:_detailTableView expandView:imageView];
    
    _workTimeArray = @[@"工作日 : 每周五5:30到17:30",@"工作日 : 每周五5:30到17:30"];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else if (section == 2) {
        return 44;
    }else {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return 108;
    }else {
        if (_workTimeArray.count > 2) {
            return 108;
        }
        return 108;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CookerHeaderView *cookerHadder = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        cookerHadder.dishNameLable.text = @"黄焖鸡米饭";
        cookerHadder.titleLable.text = @"900000人预定过该厨师";
        cookerHadder.titleString = @"立即预约";
        return cookerHadder;
    }else if (section == 2){
        OpenHeaderView *openView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openHeader"];
        openView.headerImageView.image = [UIImage imageNamed:@"dataItem.png"];
        openView.contentString = @"详细介绍";
        return openView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.hederImage = [UIImage imageNamed:@"meBackground.png"];
        cell.userNameString = @"韩亚周";
        cell.userType = CategoryCellUserTypeTeam;
        cell.levelType = CategoryCellLevelTypeIntermediate;
        cell.fractionString = @"9.7分";
        cell.distanceString = @"10000km";
        cell.specialtyArray = @[@"湘菜",@"豫菜",@"淮南菜"];
        cell.introductionString = @"公路喜剧最近几年在国内属于现象级题材，随着《人在囧途》、《泰囧》、《心花路放》等片";
        return cell;
    }else if (indexPath.section == 1) {
        CookerTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CookerTimeCell" forIndexPath:indexPath];
        cell.workDayArray = _workTimeArray;
        cell.addressString = @"河南省郑州市金水区丰庆路国基路丰庆佳怨15号楼";
        return cell;
    }else {
        CookerTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CookerTimeCell" forIndexPath:indexPath];
        /*目前只支持三天*/
        cell.workDayArray = @[@"工作日 : 每周五5:30到17:30",@"工作日 : 每周五5:30到17:30",@"工作日 : 每周五5:30到17:30"];
        cell.addressString = @"河南省郑州市二七区政通路淮南街升龙世纪花园一区四号楼";
        return cell;
    }
    
}
#pragma mark -
#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end