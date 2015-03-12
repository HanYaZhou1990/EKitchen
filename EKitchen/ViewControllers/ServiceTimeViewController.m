//
//  ServiceTimeViewController.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ServiceTimeViewController.h"

@interface ServiceTimeViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView    *_serviceTimeTableView;
    NSArray        *_serviceTimeArray;
}

@end

@implementation ServiceTimeViewController

- (void)viewDidLoad {
    self.title = @"服务时间";
    
    [super viewDidLoad];
    _serviceTimeArray = @[@"2015-03-12 上午09:00~12:00",@"2015-03-12 下午02:00~05:00",@"2015-03-13 上午09:00~12:00"];
    
    _serviceTimeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT - 44) style:UITableViewStylePlain];
    _serviceTimeTableView.delegate = self;
    _serviceTimeTableView.dataSource = self;
    [_serviceTimeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _serviceTimeTableView.tableFooterView = [UIView new];
    _serviceTimeTableView.backgroundColor = RGBA(244, 244, 244, 1);
    [self.view addSubview:_serviceTimeTableView];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _serviceTimeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textColor = UIColorFromRGB(0x666666);
    cell.textLabel.text = _serviceTimeArray[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(viewController:serviceTime:)]) {
        [_delegate viewController:self serviceTime:_serviceTimeArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
