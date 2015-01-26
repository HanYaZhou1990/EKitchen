//
//  MyAddressViewController.m
//  EKitchen
//
//  Created by julong on 15/1/21.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "MyAddressViewController.h"
#import "AddressCell.h"
@interface MyAddressViewController ()<UITableViewDataSource,UITableViewDelegate,AddressCellDelegate>
{
    UITableView *myTableView;
    
    NSInteger selectIndex;
}

@end

@implementation MyAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的地址";
    
    selectIndex = 0;
    
    [self leftBarItem];
    
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
}

//删除按钮被点击
-(void)deleteBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    DLog(@"第%ld个删除按钮被点击",btn.tag-10000);
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
    selectIndex = indexPath.row;
    [myTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124;
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
