//
//  PackageViewController.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "PackageViewController.h"

@interface PackageViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView    *_packageTableView;
    NSArray        *_packageArray;
}
@end

@implementation PackageViewController

- (void)viewDidLoad {
    self.title = @"套餐选择";
    [super viewDidLoad];
    
    _packageArray = @[@"50(含汤)＋9*（菜的个数）",@"70(含汤)＋19*（菜的个数）",@"90(含汤)＋29*（菜的个数）"];
    
    _packageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT - 44) style:UITableViewStylePlain];
    _packageTableView.delegate = self;
    _packageTableView.dataSource = self;
    [_packageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _packageTableView.tableFooterView = [UIView new];
    _packageTableView.backgroundColor = RGBA(244, 244, 244, 1);
    [self.view addSubview:_packageTableView];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _packageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textColor = UIColorFromRGB(0x666666);
    cell.textLabel.text = _packageArray[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(viewController:package:)]) {
        [_delegate viewController:self package:_packageArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
