//
//  SearchViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"searchIconGray.png"] selectedImage:[UIImage imageNamed:@"searchIconRed.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"搜索";
    
    MenuView *itemView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 44*3)];
    itemView.backgroundColor = [UIColor redColor];
    itemView.itemArray = @[@"粤菜",@"鲁菜",@"川菜",@"湘菜",@"闵菜",@"浙菜",@"苏菜",@"徽菜"];
    [self.view addSubview:itemView];
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
