//
//  MyOrderViewController.m
//  EKitchen
//
//  Created by julong on 15/1/21.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "MyOrderViewController.h"
#import "YZSegment.h"
#import "OrderCell.h"
#import "CommentViewController.h"

@interface MyOrderViewController ()<YZSegmentDelegate,UITableViewDataSource,UITableViewDelegate,OrderCellDelegate>
{
    YZSegment                  *segment;
    UITableView                *myTableView;
    
    long  typeIndex; //判断搜索类型
}
@end

@implementation MyOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的订单";
    
    [self leftBarItem];
    
    NSArray *itemTitleArray = @[@"全部",@"待付款",@"待开始",@"待评论"];
    segment = [[YZSegment alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width, 44) btnInformation:itemTitleArray contentOffSet:0];
    segment.myDelegate = self;
    
    [self setTheTableView];
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

- (void)setTheTableView
{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.tableFooterView = [UIView new];
    myTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
}

#pragma mark - YZSegmentDelegate
- (void)view:(UIScrollView *)view didSelectIndex:(NSInteger)indexOfButton
{
    switch (indexOfButton)
    {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
           
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    typeIndex = indexOfButton;
     [myTableView reloadData];
    
}

#pragma mark -
#pragma mark - OrderCellDelegate
//立即付款按钮被点击
-(void)payBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    DLog(@"第%ld个立即付款按钮被点击",btn.tag-10000);
}

//评论按钮被点击
-(void)commentBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    DLog(@"第%ld个评论按钮被点击",btn.tag-20000);
    
    CommentViewController *vc = [[CommentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return segment;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.orderDelegate = self;
    }
    
    NSString *heasImageStr = @"http://img4.duitang.com/uploads/item/201404/15/20140415233353_WwtCY.thumb.700_0.jpeg";
    NSString *userNameStr = @"韩亚周";
    NSString *pageTypeStr = @"套餐选择:中级套餐 70";
    NSString *orderTimeStr = @"上门时间:2015-12-20 上午10:00";
    NSString *addressStr = @"地点:郑州市惠济区庙里丰家小院";
    NSString *orderTypeStr = [NSString stringWithFormat:@"%ld",typeIndex];
    NSString *moneyStr = @"费用130元";
    [cell setHeadImageStr:heasImageStr andUseNameStr:userNameStr andPackageTypeStr:pageTypeStr  andOrderTimeStr:orderTimeStr andOrderTypeStr:orderTypeStr andOrderAddressStr:addressStr andOrderMoneyStr:moneyStr andRow:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
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
