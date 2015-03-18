//
//  MeViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "CWStarRateView.h"
#import "MyOrderViewController.h"
#import "ScheduleViewController.h"
#import "MyAddressViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "UserInfoViewController.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    UIButton *rightBtn;
    NSArray *sectionOneLArray;
    NSArray *sectionTwoLArray;
    NSArray *sectionImgOneLArray;
    NSArray *sectionImgTwoLArray;
    NSDictionary *_userinformationDic;
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
    
    _userinformationDic = [NSDictionary dictionary];

    [self setRightBtnItem];
    
    [self setTheTableView];
    
    [self setViewData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setViewData) name:refreshMeVCNotification object:nil];
    
}

-(void)setRightBtnItem
{
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 29, 29);
    [rightBtn setImage:[UIImage imageNamed:@"selectItem.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"selectItem.png"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigthBar = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rigthBar;
    rightBtn.hidden = YES;
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
        rightBtn.hidden = NO;
        //已登录
        NSString *userTypeStr = [PublicConfig valueForKey:userTypeEKitchen];
        NSString *memberIdStr = [PublicConfig valueForKey:userIdEKitchen];
        NSString *sessionIdStr = [PublicConfig valueForKey:userAccountEKitchen];
    NSDictionary *parameters = [NSDictionary dictionary];
    if ([userTypeStr isEqualToString:@"0"]) {
        parameters = @{@"appKey":appKeyEkitchen,@"sessionId":sessionIdStr,@"method":member_detail,@"v":versionEkitchen,@"format":formatEkitchen,@"locale":localeEkitchen,@"timestamp":timeStampEkitchen,@"memberId":memberIdStr,@"client":clientEkitchen};
    }else {
        parameters = @{@"appKey":appKeyEkitchen,@"sessionId":sessionIdStr,@"method":cooker_detail,@"v":versionEkitchen,@"format":formatEkitchen,@"locale":localeEkitchen,@"timestamp":timeStampEkitchen,@"cookerId":memberIdStr,@"client":clientEkitchen};
    }
    
    NSDictionary *addParams = @{@"sign":[YYDes generate:parameters]};
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:parameters];
    [dic addEntriesFromDictionary:addParams];
    
    [MBProgressHUD showHUDAddedToExt:self.view showMessage:@"登录中..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:BASE_PLAN_URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        if ([[responseDic allKeys] containsObject:@"errorToken"]) {
            /*登录失败*/
            [SVProgressHUD showErrorWithStatus:[PublicConfig isSpaceString:responseDic[@"subErrors"][0][@"message"] andReplace:@"资料获取失败"]];
        }else {
            _userinformationDic = responseDic;
            [myTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [SVProgressHUD showErrorWithStatus:@"登录求失败"];
    }];
    
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
        rightBtn.hidden = YES;
        //未登录
        sectionOneLArray = @[@"意见反馈",@"版本检测",@"关于"];
        sectionImgOneLArray = @[@"feedbackMeItem.png",@"updateMeItem.png",@"aboutMeItem.png"];
    }
    [myTableView reloadData];
}

#pragma mark -
#pragma mark - 按钮点击事件

-(void)rightButtonClick
{
    UserInfoViewController *vc = [[UserInfoViewController alloc]init];
    NSString *userTypeStr = [PublicConfig valueForKey:userTypeEKitchen];
    if ([userTypeStr isEqualToString:@"0"]) {
        vc.userType = UserInfoViewControllerTypeMember;
    }else {
        vc.userType = UserInfoViewControllerTypeCooker;
    }
    vc.userInfoDic = _userinformationDic;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)logoutButtonClicked:(id)sender
{
    //退出登录
    [PublicConfig setValue:@"" forKey:userIdEKitchen];
    [PublicConfig setValue:@"" forKey:userAccountEKitchen];
    [PublicConfig setValue:@"" forKey:userTypeEKitchen];
    
    [self setViewData];//刷新表格
}
//登录按钮
-(void)loginButtonClicked:(id)sender
{
    LoginViewController *vc = [[LoginViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//注册按钮
-(void)registerButtonClicked:(id)sender
{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
            userNameLabel.text = _userinformationDic[@"nickName"];
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
        NSString *useStr = cell.textLabel.text;
        if ([useStr isEqualToString:@"版本检测"])
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            NSString *verStr =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"当前版本:%@",verStr];
        }
        else if ([useStr isEqualToString:@"等级"])
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CWStarRateView *starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 0, 100, 44) numberOfStars:5];
            starRateView.scorePercent = 0.8;
            starRateView.allowIncompleteStar = NO;
            starRateView.hasAnimation = NO;
            starRateView.isTap = NO;
            [cell.contentView addSubview:starRateView];
            
            NSString *startStr = [NSString stringWithFormat:@"%.0f分",starRateView.scorePercent*10];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.text = startStr;
           
        }
    }
    if (indexPath.section==2)
    {
        cell.imageView.image = [UIImage imageNamed:[sectionImgTwoLArray objectAtIndex:indexPath.row]];
        cell.textLabel.text = [sectionTwoLArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
        NSString *useStr = cell.textLabel.text;
        if ([useStr isEqualToString:@"版本检测"])
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
           NSString *verStr =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"当前版本:%@",verStr];
        }
    }
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([PublicConfig isLogin])
    {
        //已登录
        if (indexPath.section==1)
        {
            NSString *userTypeStr = [PublicConfig valueForKey:userTypeEKitchen];
            if ([userTypeStr isEqualToString:@"0"])
            {
                //顾客
                if (indexPath.row==0)
                {
                    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else if (indexPath.row==1)
                {
                    MyAddressViewController *vc = [[MyAddressViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            if ([userTypeStr isEqualToString:@"1"])
            {
                //厨师
                if (indexPath.row==0)
                {
                    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else if (indexPath.row==1)
                {
                    ScheduleViewController *vc = [[ScheduleViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else if (indexPath.row==2)
                {
                    MyAddressViewController *vc = [[MyAddressViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
        else if (indexPath.section==2)
        {
            if (indexPath.row==0)
            {
                FeedbackViewController *vc = [[FeedbackViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row==1)
            {
                //检测版本
            }
            else if (indexPath.row==2)
            {
                AboutViewController *vc = [[AboutViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    else
    {
        //未登录
        if (indexPath.section==1)
        {
            if (indexPath.row==0)
            {
                FeedbackViewController *vc = [[FeedbackViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (indexPath.row==1)
            {
                //检测版本
            }
            else if (indexPath.row==2)
            {
                AboutViewController *vc = [[AboutViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
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
}

@end
