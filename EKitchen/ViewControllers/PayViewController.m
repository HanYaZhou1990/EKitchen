//
//  PayViewController.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView    *_payTableView;
    
    NSArray        *_payArray;
}
@end

@implementation PayViewController

- (void)viewDidLoad {
    self.title = @"支付方式";
    
    _payArray = @[@"银行卡支付",@"支付宝支付"];
    
    [super viewDidLoad];
    
    _payTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT - 44) style:UITableViewStylePlain];
    _payTableView.delegate = self;
    _payTableView.dataSource = self;
    [_payTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _payTableView.tableFooterView = [UIView new];
    _payTableView.backgroundColor = RGBA(244, 244, 244, 1);
    [self.view addSubview:_payTableView];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(20, 64*3, SCREEN_WIDTH-40, 44);
    [payButton setBackgroundColor:UIColorFromRGB(0xca1407)];
    [payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [payButton setTitleColor:UIColorFromRGB(0xF0F0F0) forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_payTableView addSubview:payButton];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _payArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textColor = UIColorFromRGB(0x666666);
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = _payArray[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger cells = [tableView numberOfRowsInSection:indexPath.section];
    for (int i = 0; i < cells; i ++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        if (i == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

#pragma mark -
#pragma mark payButtonClicked - 
- (void)payButtonClicked:(UIButton *)sender {
    NSInteger cells = [_payTableView numberOfRowsInSection:0];
    for (int i = 0; i < cells; i ++) {
        UITableViewCell *cell = [_payTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            [[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"使用%@支付",_payArray[i]] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        }else {
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
