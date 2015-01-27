//
//  UserInfoViewController.m
//  EKitchen
//
//  Created by julong on 15/1/23.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "UserInfoViewController.h"
#import "PublicSaveViewController.h"
#import "FormTheSelectorViewController.h"
#import "UserInfo.h"
#import "MessageSave.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,PublicSaveViewControllerDelegate,FormTheSelectorViewControllerDelegate>
{
    UserInfo *_userInfo;
    
    UITableView *myTableView;
    NSArray *sectionOneLArray;
    NSArray *sectionTwoLArray;
    
    NSArray         *sexArray;
    
}
@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    [self leftBarItem];
    
    if (!_userInfo)
    {
        _userInfo = [[UserInfo alloc]init];
    }
    
    //已登录
    NSString *userTypeStr = [PublicConfig valueForKey:userTypeEKitchen];
    if ([userTypeStr isEqualToString:@"0"])
    {
        //顾客
        sectionOneLArray = @[@"姓名",@"性别",@"联系方式",@"地址"];
    }
    if ([userTypeStr isEqualToString:@"1"])
    {
        //厨师
        sectionOneLArray = @[@"姓名",@"性别",@"年龄",@"籍贯",@"职业",@"联系方式",@"地址"];
        sectionTwoLArray = @[@"擅长菜系",@"可预约时间",@"拿手菜",@"介绍"];
    }
    
    
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

#pragma -
#pragma mark 数据相关

//获取个人详情
- (void)getMyInfoData
{
    
}

//更新用户个人资料
- (void)upLoadMyUserInfoData
{
    
}

#pragma -
#pragma mark PublicSaveViewControllerDelegate
-(void)publicSaveMessage:(id)sender
{
    MessageSave *messageSave = (MessageSave *)sender;
    if ([messageSave.titleString isEqualToString:@"真实姓名"])
    {
        //真实姓名
        _userInfo.nickName = messageSave.saveMessage;
    }
    if ([messageSave.titleString isEqualToString:@"年龄"])
    {
        //年龄
        _userInfo.age = [messageSave.saveMessage intValue];
    }
    
    //修改个人信息
    [self upLoadMyUserInfoData];
    
    [myTableView reloadData];
}

#pragma -
#pragma mark FormTheSelectorViewControllerDelegate

-(void)formTheSelectorMessage:(id)sender
{
    MessageSave *mS = (MessageSave *)sender;
    NSString *titleStr = mS.titleString;
    
    if ([titleStr isEqualToString:@"性别"])
    {
        _userInfo.sex = [[NSString stringWithFormat:@"%ld",(long)mS.indexPathRow] intValue];
    }
    //修改个人信息
    [self upLoadMyUserInfoData];
    
    [myTableView reloadData];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return sectionOneLArray.count;
    }
    if (section==1)
    {
        return sectionTwoLArray.count;;
    }
    if (section==2)
    {
        return sectionThreeLArray.count;;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0)
    {
        static NSString *identifier = @"cellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [sectionOneLArray objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = nil;
        
        CGFloat xxUse = SCREEN_WIDTH-87;
        if (IOS7)
        {
            xxUse = SCREEN_WIDTH-72;
        }
        //头像
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xxUse, 11.5, 37, 37)];
        headImageView.layer.cornerRadius = 4.0;
        headImageView.layer.masksToBounds = YES;
        headImageView.userInteractionEnabled = YES;
        headImageView = [PublicConfig setHeadImageView:headImageView withImageStr:_userInfo.headImageUrl andUserObject:_userInfo];
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMyDetailImg:)];
        [headImageView addGestureRecognizer:singleTap];
        [cell.contentView addSubview:headImageView];
        return cell;
        
    }
    else
    {
        static NSString *identifier = @"cellIdentifier";
        
        SizeToRightLabelCell *cell = (SizeToRightLabelCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil)
        {
            cell = [[SizeToRightLabelCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        if (indexPath.section == 0)
        {
            NSString *leftStr = [sectionOneLArray objectAtIndex:indexPath.row];
            if (indexPath.row==1)
            {
                //真实姓名
                NSString *contentStr = [PublicConfig isSpaceString:_userInfo.nickName andReplace:@"无"];
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            else if (indexPath.row==2)
            {
                //O信号
                NSString *contentStr = [PublicConfig isSpaceString:_userInfo.account andReplace:_userInfo.userId];
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else if (indexPath.row==3)
            {
                //性别
                NSString *sexString = @"";
                if ([_userInfo.sex isEqualToString:@"0"])
                {
                    sexString = @"男";
                }
                if ([_userInfo.sex isEqualToString:@"1"])
                {
                    sexString = @"女";
                }
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:sexString andUseSign:@"1"];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            else if (indexPath.row==4)
            {
                //年龄
                NSString *contentStr = [PublicConfig isSpaceString:_userInfo.age andReplace:@""];
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            
        }
        if (indexPath.section == 1)
        {
            NSString *leftStr = [sectionTwoLArray objectAtIndex:indexPath.row];
            if (indexPath.row==0)
            {
                //身份
                NSString *contentStr = @"其他";
                if ([_userInfo.role isEqualToString:@"4"])
                {
                    contentStr = @"学生";
                }
                else if ([_userInfo.role isEqualToString:@"5"])
                {
                    contentStr = @"老师";
                }
                else if ([_userInfo.role isEqualToString:@"6"])
                {
                    contentStr = @"家长及其他";
                }
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            if (indexPath.row==1)
            {
                //所在地
                NSString *contentStr = [PublicConfig isSpaceString:_userInfo.regionName andReplace:@""];
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            if (indexPath.row==2)
            {
                //学校
                NSString *contentStr = [PublicConfig isSpaceString:_userInfo.schoolName andReplace:@"未填写"];
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            if (indexPath.row==3)
            {
                //注册时间
                NSString *contentStr = [PublicConfig isSpaceString:_userInfo.regtime andReplace:@""];
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        if (indexPath.section == 2)
        {
            NSString *leftStr = [sectionThreeLArray objectAtIndex:indexPath.row];
            if (indexPath.row==0)
            {
                NSString *contentStr = [PublicConfig isSpaceString:_userInfo.personSign andReplace:@""];
                [cell setTitleLeftLabelStr:leftStr andRightLabelStr:contentStr andUseSign:@"1"];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = nil;
        
        
        return cell;
    }
    return nil;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            //选择头像
            //判断用户没有选择图片 弹出相机界面
            [self pickImageFromAlbum];
        }
        if (indexPath.row==1)
        {
            //名字
            PublicSaveViewController *psVC = [[PublicSaveViewController alloc]init];
            //传个人信息
            psVC.isSaveVerification = @"1";
            psVC.titleStr = [sectionOneLArray objectAtIndex:indexPath.row];
            psVC.textFieldStr = _userInfo.nickName;
            psVC.isUsedStr = @"短文本";
            psVC.publicSaveVCdelegate = self;
            psVC.maxLenth = 15;
            psVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:psVC animated:YES];
        }
        if (indexPath.row==3)
        {
            //性别
            FormTheSelectorViewController *ftsvc = [[FormTheSelectorViewController alloc] init];
            ftsvc.titleStr = @"性别";
            ftsvc.formTheSelectorVCdelegate = self;
            NSString *typeStr=_userInfo.sex;
            NSIndexPath *index = [NSIndexPath indexPathForRow:[typeStr integerValue] inSection:0];
            ftsvc.lastIndexPath =index;
            ftsvc.dataSource = sexArray;
            ftsvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ftsvc animated:YES];
        }
        if (indexPath.row==4)
        {
            //年龄
            PublicSaveViewController *psVC = [[PublicSaveViewController alloc]init];
            psVC.isSaveVerification = @"1";
            psVC.titleStr = [sectionOneLArray objectAtIndex:indexPath.row];
            psVC.textFieldStr = _userInfo.age;
            psVC.isUsedStr = @"短文本";
            psVC.publicSaveVCdelegate = self;
            psVC.maxLenth = 2;
            psVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:psVC animated:YES];
        }
    }
    if (indexPath.section==1)
    {
        if (indexPath.row==1)
        {
            //所在地
            SelectRegionViewController *vc = [[SelectRegionViewController alloc]init];
            vc.selectRegionVCdelegate = self;
            vc.titleStr = @"选择所在地";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row==2)
        {
            //学校
            PublicSaveViewController *psVC = [[PublicSaveViewController alloc]init];
            psVC.isSaveVerification = @"1";
            psVC.titleStr = [sectionTwoLArray objectAtIndex:indexPath.row];
            psVC.textFieldStr = _userInfo.schoolName;
            psVC.isUsedStr = @"短文本";
            psVC.publicSaveVCdelegate = self;
            psVC.maxLenth = 30;
            psVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:psVC animated:YES];
        }
    }
    if (indexPath.section==2)
    {
        if (indexPath.row==0)
        {
            PublicSaveViewController *psVC = [[PublicSaveViewController alloc]init];
            //传个人信息
            psVC.isSaveVerification = @"1";
            psVC.titleStr = [sectionThreeLArray objectAtIndex:indexPath.row];
            psVC.textFieldStr = _userInfo.personSign;
            psVC.isUsedStr = @"长文本";
            psVC.maxLenth = 60;
            psVC.publicSaveVCdelegate = self;
            psVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:psVC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 20;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2)
    {
        return 20;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widthUse = SCREEN_WIDTH-40-105;
    if (IOS7)
    {
        widthUse = SCREEN_WIDTH-20-105;
    }
    CGFloat heightUse=44;
    
    if (indexPath.section==0&&indexPath.row==0)
    {
        return 60;
    }
    if (indexPath.section==1)
    {
        if (indexPath.row==1)
        {
            //所在地
            NSString *ruleString = [PublicConfig isSpaceString:_userInfo.regionName andReplace:@"无"];
            heightUse = [PublicConfig height:ruleString widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:14]]+24;
        }
        if (indexPath.row==2)
        {
            //学校
            NSString *ruleString = [PublicConfig isSpaceString:_userInfo.schoolName andReplace:@"无"];
            heightUse = [PublicConfig height:ruleString widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:14]]+24;
        }
    }
    if (indexPath.section==2)
    {
        if (indexPath.row==0)
        {
            NSString *ruleString = [PublicConfig isSpaceString:_userInfo.personSign andReplace:@"未填写"];
            heightUse = [PublicConfig height:ruleString widthOfFatherView:widthUse  textFont:[UIFont systemFontOfSize:14]]+24;
        }
    }
    if (heightUse<44)
    {
        heightUse=44;
    }
    return heightUse;
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
