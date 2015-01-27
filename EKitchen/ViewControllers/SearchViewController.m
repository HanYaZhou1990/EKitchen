//
//  SearchViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController (){
    NSArray       *__sectionTitleArray;
    NSArray       *__section2Array;
}

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
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"搜索";
    
    __sectionTitleArray = @[@"热门推荐",@"历史纪录"];
    __section2Array = @[@"粤菜",@"清空历史纪录"];
    
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT) style:UITableViewStylePlain];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    [_searchTableView registerClass:[RecommendCell class] forCellReuseIdentifier:@"commendCell"];
    [_searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _searchTableView.tableHeaderView.backgroundColor = RGBA(244, 244, 244, 1);
    _searchTableView.tableFooterView = [UIView new];
    [self.view addSubview:_searchTableView];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return __sectionTitleArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionLable = [[UILabel alloc] init];
    sectionLable.font = [UIFont systemFontOfSize:14.0];
    sectionLable.textColor = UIColorFromRGB(0x666666);
    sectionLable.backgroundColor = UIColorFromRGB(0xF0F0F0);
    sectionLable.layer.borderWidth = 0.5;
    sectionLable.layer.borderColor = UIColorFromRGB(0xCACACA).CGColor;
    sectionLable.text = [NSString stringWithFormat:@"    %@",__sectionTitleArray[section]];
    return sectionLable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return __section2Array.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ITEM_Height*3;
    }else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commendCell" forIndexPath:indexPath];
        cell.itemArray = @[@"粤菜",@"鲁菜",@"川菜",@"湘菜",@"闵菜",@"浙菜",@"苏菜",@"徽菜"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cellDelegate = self;
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = __section2Array[indexPath.row];
        cell.textLabel.textColor = UIColorFromRGB(0x3D3D3D);
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        if (indexPath.row == __section2Array.count-1) {
            cell.textLabel.textColor = [UIColor redColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OneCategoryViewController *categoryViewController = [[OneCategoryViewController alloc] init];
    categoryViewController.categoryString = __section2Array[indexPath.row];
    categoryViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryViewController animated:YES];
}

#pragma mark -RecommendCellDelegate
- (void)tableViewcell:(RecommendCell *)cell itemClick:(MenuView *)view itemIndex:(NSInteger)index{
    OneCategoryViewController *categoryViewController = [[OneCategoryViewController alloc] init];
    categoryViewController.categoryString = @[@"粤菜",@"鲁菜",@"川菜",@"湘菜",@"闵菜",@"浙菜",@"苏菜",@"徽菜"][index];
    categoryViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
