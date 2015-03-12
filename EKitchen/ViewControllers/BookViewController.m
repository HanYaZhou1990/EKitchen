//
//  BookViewController.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView             *_bookTableView;
    NSMutableArray          *_contentArray;
    UILabel                 *_priceLable;
}

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title =@"立即预订";

    _contentArray = [@[@"河南省郑州市二七区政通路淮南街升龙世纪花园一区x楼xxx室河南入迷信息技术有限公司 13535353535",@"服务时间",@"套餐"] mutableCopy];
    
    _bookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT - 44) style:UITableViewStyleGrouped];
    _bookTableView.delegate = self;
    _bookTableView.dataSource = self;
    [_bookTableView registerClass:[OpenHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [_bookTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_bookTableView registerClass:[TextViewCell class] forCellReuseIdentifier:@"TextViewCell"];
    [self.view addSubview:_bookTableView];
    
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT-NAV_HEIGHT-44, SCREEN_WIDTH/2-20, 44)];
    _priceLable.textColor = UIColorFromRGB(0xca1407);
    _priceLable.font = [UIFont systemFontOfSize:16.0];
    _priceLable.adjustsFontSizeToFitWidth = YES;
    _priceLable.text = @"共计: ¥1999元";
    [self.view addSubview:_priceLable];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(SCREEN_WIDTH - 120, SCREEN_HEIGHT - NAV_HEIGHT - 40, 100, 36);
    [commitButton setBackgroundColor:UIColorFromRGB(0xca1407)];
    [commitButton setTitleColor:UIColorFromRGB(0xF0F0F0) forState:UIControlStateNormal];
    [commitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        OpenHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        headerView.openHeaderViewType = OpenHeaderViewTypeNone;
        headerView.contentString = @"用餐地点";
        return headerView;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else {
        return 6;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 104;
    }else {
        return 64;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = UIColorFromRGB(0x666666);
        cell.textLabel.text = _contentArray[indexPath.row];
        cell.textLabel.numberOfLines = 0;
        return cell;
    }else {
        TextViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell" forIndexPath:indexPath];
        return textCell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        MyAddressViewController *addressViewController = [[MyAddressViewController alloc] init];
        addressViewController.delegate = self;
        [self.navigationController pushViewController:addressViewController animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        ServiceTimeViewController *serviceViewController = [[ServiceTimeViewController alloc] init];
        serviceViewController.delegate = self;
        [self.navigationController pushViewController:serviceViewController animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        PackageViewController *packageViewController = [[PackageViewController alloc] init];
        packageViewController.delegate = self;
        [self.navigationController pushViewController:packageViewController animated:YES];
    }
}

#pragma mark -
#pragma mark commentButtonClicked -
- (void)commentButtonClicked:(UIButton *)button {
    PayViewController *payVC = [[PayViewController alloc] init];
    [self.navigationController pushViewController:payVC animated:YES];
}

#pragma mark -
#pragma mark MyAddressViewControllerDelegate -
- (void)viewController:(MyAddressViewController *)viewController address:(NSString *)addressString{
    UITableViewCell *cell = [_bookTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.textLabel.text = addressString;
}

#pragma mark -
#pragma mark ServiceTimeViewControllerDelegate -
- (void)viewController:(PackageViewController *)viewController serviceTime:(NSString *)timeString {
    UITableViewCell *cell = [_bookTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",_contentArray[1],timeString];
}
#pragma mark -
#pragma mark PackageViewControllerDelegate -
- (void)viewController:(PackageViewController *)viewController package:(NSString *)packageString {
    UITableViewCell *cell = [_bookTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",_contentArray[2],packageString];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
