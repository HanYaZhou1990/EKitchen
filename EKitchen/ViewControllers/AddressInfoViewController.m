//
//  AddressInfoViewController.m
//  EKitchen
//
//  Created by julong on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AddressInfoViewController.h"

@interface AddressInfoViewController ()

@end

@implementation AddressInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.typeStr isEqualToString:@"0"])
    {
        self.title = @"添加收货地址";
    }
    else if ([self.typeStr isEqualToString:@"1"])
    {
        self.title = @"编辑收货地址";
    }
    else if ([self.typeStr isEqualToString:@"2"])
    {
        self.title = @"选择收货地址";
    }
    
    
    [self leftBarItem];
}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 29, 29);//图片宽29+5间隔 共40
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *leftBarBtnSpace = [PublicConfig setLeftBarBtnSpaceWidth];
    self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects:leftBarBtnSpace, leftBarButton, nil];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
