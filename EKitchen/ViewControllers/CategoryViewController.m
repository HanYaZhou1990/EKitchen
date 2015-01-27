//
//  CategoryViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
{
    YZSegment                  *__segment;
    UITableView                *__categoryTableView;
    NSArray                    *__listArray;
}
@end

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"categoryIconGray.png"] selectedImage:[UIImage imageNamed:@"categoryIconRed.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"分类";

    NSArray *itemTitleArray = @[@"中国菜",@"外国菜"];
    __segment = [[YZSegment alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44) btnInformation:itemTitleArray contentOffSet:0];
    __segment.myDelegate = self;
    
    __listArray = @[@"粤菜",@"鲁菜",@"川菜",@"湘菜",@"闵菜",@"浙菜",@"苏菜",@"徽菜"];
    __categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT-TAB_HEIGHT) style:UITableViewStylePlain];
    __categoryTableView.dataSource = self;
    __categoryTableView.delegate = self;
    [__categoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    __categoryTableView.tableFooterView = [UIView new];
    [self.view addSubview:__categoryTableView];
}

#pragma mark - YZSegmentDelegate
- (void)view:(UIScrollView *)view didSelectIndex:(NSInteger)indexOfButton
{
    switch (indexOfButton)
    {
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return __segment;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = __listArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OneCategoryViewController *categoryViewController = [[OneCategoryViewController alloc] init];
    categoryViewController.categoryString = __listArray[indexPath.row];
    categoryViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
