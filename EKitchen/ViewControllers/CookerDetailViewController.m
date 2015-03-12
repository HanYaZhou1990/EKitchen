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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    [_detailTableView registerClass:[CookerHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [_detailTableView registerClass:[OpenHeaderView class] forHeaderFooterViewReuseIdentifier:@"openHeader"];
    [_detailTableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"cell"];
    [_detailTableView registerClass:[CookerTimeCell class] forCellReuseIdentifier:@"CookerTimeCell"];
    [_detailTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
    [self.view addSubview:_detailTableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    [imageView setImage:[UIImage imageNamed:@"meBackground.png"]];
    
    _headerView = [ExpandHeader expandWithScrollView:_detailTableView expandView:imageView];
    
    _workTimeArray = @[@"工作日 : 每周五5:30到17:30",@"工作日 : 每周五5:30到17:30"];
    
    [self backbutton];
    
    UIButton *checkAllCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkAllCommentButton.frame = CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44);
    [checkAllCommentButton setTitle:@"查看全部评论" forState:UIControlStateNormal];
    [checkAllCommentButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [checkAllCommentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [checkAllCommentButton addTarget:self action:@selector(checkAllCommentsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkAllCommentButton];
}

#pragma mark -
#pragma mark backButton -

- (void)backbutton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(16, 26, 36, 36);
    backButton.layer.cornerRadius = 18.0;
    backButton.clipsToBounds = YES;
    [backButton setBackgroundColor:UIColorFromRGB(0x666666)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)checkAllCommentsButtonClick:(UIButton *)sender {
    AllCommentsViewController *viewController = [[AllCommentsViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else if (section == 2) {
        return 44;
    }else if (section == 3) {
        return 44;
    }else if (section == 4) {
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
        cookerHadder.delegate = self;
        cookerHadder.titleLable.text = @"900000人预定过该厨师";
        cookerHadder.titleString = @"立即预定";
        return cookerHadder;
    }else if (section == 1) {
        return nil;
    }else if (section == 2) {
        OpenHeaderView *openView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openHeader"];
        openView.headerImageView.image = [UIImage imageNamed:@"dataItem.png"];
        openView.headerViewSection = section;
        openView.delegate = self;
        openView.contentString = @"详细介绍";
        if (_isOpenSection[section]) {
            openView.isOpen = YES;
        }else {
            openView.isOpen = NO;
        }
        return openView;
    }else if (section == 3){
        OpenHeaderView *openView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openHeader"];
        openView.headerImageView.image = [UIImage imageNamed:@"orderItem.png"];
        openView.contentString = @"预定订单";
        if (_isOpenSection[section]) {
            openView.isOpen = YES;
        }else {
            openView.isOpen = NO;
        }
        openView.headerViewSection = section;
        openView.delegate = self;
        return openView;
    }else {
        OpenHeaderView *openView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openHeader"];
        openView.headerImageView.image = [UIImage imageNamed:@"scoreItem.png"];
        openView.contentString = @"顾客评价";
        openView.openHeaderViewType = OpenHeaderViewTypeStar;
        return openView;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 1;
    }else if (section == 2 || section == 3){
        if (_isOpenSection[section]) {
            return 2;
        }else {
            return 0;
        }
    }else {
        return 2;
    }
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
    }else if (indexPath.section == 2 || indexPath.section == 3 ) {
        CookerTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CookerTimeCell" forIndexPath:indexPath];
        /*目前只支持三天*/
        cell.workDayArray = @[@"工作日 : 每周五5:30到17:30",@"工作日 : 每周五5:30到17:30",@"工作日 : 每周五5:30到17:30"];
        cell.addressString = @"河南省郑州市二七区政通路淮南街升龙世纪花园一区四号楼";
        return cell;
    }else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        cell.userNameString = @"看名字霸气不";
        cell.commentTimeString = @"2015-3-12";
        cell.commentContenString = @"做的饭很不错，很好吃哦，绝对的满分，好评，下次还请他!";
        return cell;
    }
}
#pragma mark -
#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark OpenHeaderViewDelegate -
- (void)headerView:(OpenHeaderView *)headerView didSelectedSection:(NSInteger)section {
    _isOpenSection[section] =!_isOpenSection[section];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:headerView.headerViewSection];
    [_detailTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -
#pragma mark CookerHeaderViewDelegate -
- (void)headerView:(CookerHeaderView *)headerView clickbutton:(UIButton *)sender {
    BookViewController *bookVC = [[BookViewController alloc] init];
    [self.navigationController pushViewController:bookVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
