//
//  RootTabBarViewController.m
//  EKitchen
//
//  Created by julong on 15/1/16.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "SearchViewController.h"
#import "LazyViewController.h"
#import "MeViewController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTabbar];
}

-(void)initTabbar
{
    NSMutableArray *viewControllers = [[NSMutableArray alloc]init];
    
    //首页
    HomeViewController *hvc = [[HomeViewController alloc]init];
    UINavigationController *hnav = [[UINavigationController alloc]initWithRootViewController:hvc];
    [viewControllers addObject:hnav];
    
    //分类
    CategoryViewController *cvc = [[CategoryViewController alloc]init];
    UINavigationController *cnav = [[UINavigationController alloc]initWithRootViewController:cvc];
    [viewControllers addObject:cnav];
    
    //搜索
    SearchViewController *svc = [[SearchViewController alloc]init];
    UINavigationController *snav = [[UINavigationController alloc]initWithRootViewController:svc];
    [viewControllers addObject:snav];
    
    //懒人
    LazyViewController *lvc = [[LazyViewController alloc]init];
    UINavigationController *lnav = [[UINavigationController alloc]initWithRootViewController:lvc];
    [viewControllers addObject:lnav];

    //我
    MeViewController *mvc = [[MeViewController alloc]init];
    UINavigationController *mnav = [[UINavigationController alloc]initWithRootViewController:mvc];
    [viewControllers addObject:mnav];
    
    self.viewControllers = viewControllers;
    
    self.tabBar.tintColor = UIColorFromRGB(0xca1407);//取tabItem颜色 橘色
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      UIColorFromRGB(0xca1407), NSForegroundColorAttributeName,
      nil]forState:UIControlStateSelected];
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
