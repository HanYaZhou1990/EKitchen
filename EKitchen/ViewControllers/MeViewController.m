//
//  MeViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSArray *sectionOneLArray;
    NSArray *sectionTwoLArray;
    NSArray *sectionImgOneLArray;
    NSArray *sectionImgTwoLArray;
}
@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"meIconGray.png"] selectedImage:[UIImage imageNamed:@"meIconRed.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title = @"我的";
    
    [self setTheTableView];
    
    [self setViewData];
}

//设置tableview属性
- (void)setTheTableView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -220, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT+220) style:UITableViewStyleGrouped];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    [self.view addSubview:myTableView];
}

//组织表格数据源
-(void)setViewData
{
    if ([PublicConfig isLogin])
    {
        //已登录
        NSString *userTypeStr = [PublicConfig valueForKey:userTypeEKitchen];
        if ([userTypeStr isEqualToString:@"0"])
        {
            //顾客
            sectionOneLArray = @[@"我的订单",@"我的地址"];
            sectionImgOneLArray = @[@"orderMeItem.png",@"mapMeItem.png"];
        }
        if ([userTypeStr isEqualToString:@"1"])
        {
            //厨师
            sectionOneLArray = @[@"我的订单",@"日程安排",@"我的地址",@"等级"];
            sectionImgOneLArray = @[@"orderMeItem.png",@"calendarMeItem.png",@"mapMeItem.png",@"gradeMeItem.png"];
        }
        sectionTwoLArray = @[@"意见反馈",@"版本检测",@"关于"];
        sectionImgTwoLArray = @[@"feedbackMeItem.png",@"updateMeItem.png",@"aboutMeItem.png"];
    }
    else
    {
        //未登录
        sectionOneLArray = @[@"意见反馈",@"版本检测",@"关于"];
        sectionImgOneLArray = @[@"feedbackMeItem.png",@"updateMeItem.png",@"aboutMeItem.png"];
    }

    [myTableView reloadData];
}

#pragma mark -
#pragma mark - 按钮点击事件

-(void)logoutButtonClicked:(id)sender
{
    //退出登录
    [PublicConfig setValue:@"" forKey:userAccountEKitchen];
    [PublicConfig setValue:@"" forKey:userTypeEKitchen];
    
    [self setViewData];//刷新表格
}
//登录按钮
-(void)loginButtonClicked:(id)sender
{
    DLog(@"登录按钮被点击");
}
//注册按钮
-(void)registerButtonClicked:(id)sender
{
    DLog(@"注册按钮被点击");
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([PublicConfig isLogin])
    {
        //已登录
        return 3;
    }
    else
    {
        //未登录
         return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (section==0)
        {
            return 1;
        }
        else if (section==1)
        {
            return sectionOneLArray.count;
        }
        else if (section==2)
        {
            return sectionTwoLArray.count;;
        }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    //    if (cell==nil)
    //    {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    //    }
    
    if (indexPath.section==0)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 380);
        imageView.image = [UIImage imageNamed:@"meBackground.png"];
        [cell.contentView addSubview:imageView];

        if ([PublicConfig isLogin])
        {
            //已登录
            NSString *userTypeStr = [PublicConfig valueForKey:userTypeEKitchen];
            
           //头像 头像可点击编辑  名字
            UIImageView *headImageView =  [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 240, 60, 60)];
            headImageView.image = [UIImage imageNamed:@"meBackground.png"];
            headImageView.layer.masksToBounds=YES;
            headImageView.layer.cornerRadius=30;
            headImageView.layer.borderWidth=2.0;
            headImageView.layer.borderColor=[UIColor whiteColor].CGColor;
            headImageView.contentMode = UIViewContentModeScaleAspectFill;
            [cell.contentView addSubview:headImageView];
            
            UILabel *userNameLabel = [[UILabel alloc]init];
            userNameLabel.frame = CGRectMake(0, headImageView.frame.size.height+headImageView.frame.origin.y+20, SCREEN_WIDTH, 15);
            userNameLabel.textAlignment = NSTextAlignmentCenter;
            userNameLabel.textColor = [UIColor whiteColor];
            userNameLabel.font = [UIFont systemFontOfSize:14];
            userNameLabel.text = @"韩亚周";
            userNameLabel.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:userNameLabel];

            if ([userTypeStr isEqualToString:@"1"])
            {
                //厨师 级别 菜系
                UILabel *cookLabel = [[UILabel alloc]init];
                cookLabel.frame = CGRectMake(0, userNameLabel.frame.size.height+userNameLabel.frame.origin.y+10, SCREEN_WIDTH, 15);
                cookLabel.textAlignment = NSTextAlignmentCenter;
                cookLabel.textColor = [UIColor whiteColor];
                cookLabel.font = [UIFont systemFontOfSize:12];
                cookLabel.text = @"湘菜 豫菜 淮扬菜";
                cookLabel.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:cookLabel];
                
            }
        }
        else
        {
            //未登录  登录 注册按钮
            
            UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
            loginButton.frame = CGRectMake((SCREEN_WIDTH-200)/3, 275, 100, 50);
            [loginButton setBackgroundColor:RGBA(51, 189, 97, 1)];
            [loginButton setTitle:@"登录" forState:UIControlStateNormal];
            [loginButton setTitle:@"登录" forState:UIControlStateHighlighted];
            loginButton.layer.masksToBounds=YES;
            loginButton.layer.cornerRadius=4;
            [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:loginButton];
            
            UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            registerButton.frame = CGRectMake((SCREEN_WIDTH-200)/3*2+100, loginButton.frame.origin.y, 100, 50);
            [registerButton setBackgroundColor:RGBA(255, 136, 0, 1)];
            [registerButton setTitle:@"注册" forState:UIControlStateNormal];
            [registerButton setTitle:@"注册" forState:UIControlStateHighlighted];
            registerButton.layer.masksToBounds=YES;
            registerButton.layer.cornerRadius=4;
            [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:registerButton];
 
        }
        
    }
    if (indexPath.section==1)
    {
        cell.imageView.image = [UIImage imageNamed:[sectionImgOneLArray objectAtIndex:indexPath.row]];
        cell.textLabel.text = [sectionOneLArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.section==2)
    {
        cell.imageView.image = [UIImage imageNamed:[sectionImgTwoLArray objectAtIndex:indexPath.row]];
        cell.textLabel.text = [sectionTwoLArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    long sectionUse;
    if ([PublicConfig isLogin])
    {
        //已登录
        sectionUse = 2;
    }
    else
    {
        //未登录
        sectionUse = 1;
    }
    if (section == sectionUse)
    {
        UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        logoutButton.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 50);
        [logoutButton setBackgroundColor:UIColorFromRGB(0xca1407)];
        [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutButton setTitle:@"退出登录" forState:UIControlStateHighlighted];
        [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logoutButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        logoutButton.layer.masksToBounds=YES;
        logoutButton.layer.cornerRadius=4;
        [logoutButton addTarget:self action:@selector(logoutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        [footView setBackgroundColor:[UIColor clearColor]];
        [footView addSubview:logoutButton];
        
        return footView;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    long sectionUse;
    if ([PublicConfig isLogin])
    {
        //已登录
        sectionUse = 2;
    }
    else
    {
        //未登录
        sectionUse = 1;
    }
    if (section==sectionUse)
    {
        return 90;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 380;
    }
    return 44;
}

- (void)didReceiveMemoryWarning
{
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
