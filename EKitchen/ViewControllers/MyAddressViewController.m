//
//  MyAddressViewController.m
//  EKitchen
//
//  Created by julong on 15/1/21.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "MyAddressViewController.h"
#import "AddressCell.h"
#import "AddressInfoViewController.h"
#import "AddressInfo.h"

@interface MyAddressViewController ()<UITableViewDataSource,UITableViewDelegate,AddressCellDelegate,UIAlertViewDelegate>
{
    UITableView *myTableView;
    NSInteger selectIndex; //设置默认选择参数
}

@end

@implementation MyAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.typeStr isEqualToString:@"1"])
    {
         self.title = @"选择收货地址";
    }
    else
    {
         self.title = @"我的地址";
    }
    
    selectIndex = 0;
    
    [self leftBarItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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

-(void)rightButtonClick
{
    AddressInfoViewController *vc = [[AddressInfoViewController alloc]init];
    vc.typeStr = @"0"; //新增
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
}

#pragma mark -
#pragma mark - AddressCellDelegate
//编辑按钮被点击
-(void)editBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    DLog(@"第%ld个编辑按钮被点击",btn.tag-100);
    
    //临时
    AddressInfo *_addressInfo = [[AddressInfo alloc]init];
    _addressInfo.userName = @"韩亚周";
    _addressInfo.phoneNumber = @"15092377782";
    _addressInfo.area = @"河南省郑州市金水区";
    _addressInfo.address = @"庙里多菱路与溜达大街交叉口富甲小区15号楼225室";
    
    AddressInfoViewController *vc = [[AddressInfoViewController alloc]init];
    vc.typeStr = @"1"; //编辑
    vc._addressInfo = _addressInfo;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//删除按钮被点击
-(void)deleteBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定要删除收货地址么?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = btn.tag;
    [alertView show];
    
}

//设置默认按钮被点击
-(void)selectBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    DLog(@"第%ld个设置默认按钮被点击",btn.tag-20000);
    
    selectIndex = btn.tag-20000;
    [myTableView reloadData];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.addressDelegate = self;
    }
    NSString *userNameStr = @"韩亚周 15092377782";
    NSString *addressStr = @"河南省郑州市金水区庙里多菱路与溜达大街交叉口富甲小区15号楼225室";
    BOOL isDefult = NO;
    if (indexPath.row==selectIndex)
    {
        isDefult=YES;
    }
    [cell setUseNameStr:userNameStr andAddressStr:addressStr andIsDefult:isDefult andRow:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //选择收货地址 点击后退并往外传值
    if ([_delegate respondsToSelector:@selector(viewController:address:)]) {
        [_delegate viewController:self address:@"河南省郑州市金水区庙里多菱路与溜达大街交叉口富甲小区15号楼225室  15092377782"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124;
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
      DLog(@"第%ld个确定删除按钮被点击",alertView.tag-10000);
    if (buttonIndex==0)
    {
        DLog(@"取消");
    }
    else
    {
        DLog(@"删除");
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
