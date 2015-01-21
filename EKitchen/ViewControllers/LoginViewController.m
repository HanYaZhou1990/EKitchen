//
//  LoginViewController.m
//  EKitchen
//
//  Created by julong on 15/1/19.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "LoginViewController.h"
#import "HYZTextField.h"
#import "FindViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
     HYZTextField          *userNameField;
     HYZTextField          *userPswField;
    
     UIView *selectBgView; //设置选择背景视图
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self leftBarItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightItem;

    [self setLoginView];
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
    if (selectBgView)
    {
        [selectBgView removeFromSuperview];
        selectBgView=nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick
{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 初始化界面

//初始化登陆界面
-(void)setLoginView
{
    userNameField = [[HYZTextField alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 30)];
    userNameField.placeholder = @"手机号";
    userNameField.font = [UIFont systemFontOfSize:16];
    userNameField.textColor = [UIColor blackColor];
    userNameField.borderStyle = UITextBorderStyleNone;
    userNameField.delegate =self;
    userNameField.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:userNameField];
    
    
    userPswField = [[HYZTextField alloc]initWithFrame:CGRectMake(userNameField.frame.origin.x, userNameField.frame.size.height+userNameField.frame.origin.y+20, userNameField.frame.size.width, userNameField.frame.size.height)];
    userPswField.placeholder = @"密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.delegate =self;
    userPswField.returnKeyType = UIReturnKeyDone;
    userPswField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userPswField];
    
    UIButton *findPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findPwdButton.frame = CGRectMake(SCREEN_WIDTH-120, userPswField.frame.size.height+userPswField.frame.origin.y+5 , 100, 40);
    [findPwdButton setBackgroundColor:[UIColor clearColor]];
    [findPwdButton setTitle:@"找回密码?" forState:UIControlStateNormal];
    [findPwdButton setTitleColor:UIColorFromRGB(0xca1407) forState:UIControlStateNormal];
    [findPwdButton addTarget:self action:@selector(findPwdButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPwdButton];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(userNameField.frame.origin.x, findPwdButton.frame.size.height+findPwdButton.frame.origin.y+20, userNameField.frame.size.width, 50);
    [loginButton setBackgroundColor:RGBA(210, 6, 18, 1)];
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [loginButton setTitle:@"登  录" forState:UIControlStateHighlighted];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    loginButton.layer.masksToBounds=YES;
    loginButton.layer.cornerRadius=4;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];

}

//初始化选择页面
-(void)initSelectView
{
    selectBgView = [[UIView alloc]init];
    selectBgView.frame = CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT);
    selectBgView.backgroundColor = [UIColor clearColor];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;//获取window
    [keyWindow addSubview:selectBgView];
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [selectView setBackgroundColor:[UIColor blackColor]];
    selectView.alpha = 0.8;
    [selectBgView addSubview:selectView];
    
    
    UIButton *customerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customerButton.frame = CGRectMake((SCREEN_WIDTH-200)/3, (SCREEN_HEIGHT-100)/2, 100, 100);
    [customerButton setBackgroundColor:RGBA(24, 123, 225, 1)];
    [customerButton setTitle:@"我是顾客" forState:UIControlStateNormal];
    [customerButton setTitle:@"我是顾客" forState:UIControlStateHighlighted];
    [customerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    customerButton.layer.masksToBounds=YES;
    customerButton.layer.cornerRadius=50;
    customerButton.tag = 100;
    [customerButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [selectBgView addSubview:customerButton];
    
    UIButton *cookerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cookerButton.frame = CGRectMake(((SCREEN_WIDTH-200)/3)*2+100, (SCREEN_HEIGHT-100)/2, 100, 100);
    [cookerButton setBackgroundColor:RGBA(210, 6, 18, 1)];
    [cookerButton setTitle:@"我是厨师" forState:UIControlStateNormal];
    [cookerButton setTitle:@"我是厨师" forState:UIControlStateHighlighted];
    [cookerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cookerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    cookerButton.layer.masksToBounds=YES;
    cookerButton.layer.cornerRadius=50;
    cookerButton.tag = 101;
    [cookerButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [selectBgView addSubview:cookerButton];
  
}

-(void)showSelectView
{
    selectBgView.frame = CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
}

-(void)removeSelectView
{
    selectBgView.frame = CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT);
}


#pragma mark -
#pragma mark 按钮点击事件

//找回密码点击
-(void)findPwdButtonClicked:(id)sender
{
    FindViewController *vc = [[FindViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//登录点击
-(void)loginButtonClicked:(id)sender
{
    //验证不可为空
    [userNameField resignFirstResponder];
    [userPswField resignFirstResponder];
    
    if(userNameField.text == nil
       || userPswField.text == nil
       || (userNameField.text && [[userNameField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
       || (userPswField.text && [[userPswField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]))
    {
        [PublicConfig waringInfo:@"用户名或密码不能为空"];
    }
    else
    {
        //选择类型 顾客 Or 厨师
        //登录协议
        if (!selectBgView)
        {
            [self initSelectView];
        }
        [self showSelectView];
    }
}

//用户类型点击
-(void)buttonClicked:(id)sender
{
    NSString *loginUserType = @"";
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag)
    {
        case 100:
        {
            //我是顾客
            loginUserType = @"0";
        }
            break;
        case 101:
        {
            //我是厨师
            loginUserType = @"1";
        }
            break;
            
        default:
            break;
    }
    [self removeSelectView];
    [self sendLoginDataWithLoginType:loginUserType];
    
}

//登录协议
-(void)sendLoginDataWithLoginType:(NSString *)loginTypeStr
{
    //发送登录协议
    
    
    //登陆成功 设置登录id跟登录用户类型得值 刷新设置界面 后退至设置界面
    [PublicConfig setValue:@"userid" forKey:userAccountEKitchen];
    [PublicConfig setValue:loginTypeStr forKey:userTypeEKitchen];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:refreshMeVCNotification object:nil];
    
    if (selectBgView)
    {
        [selectBgView removeFromSuperview];
        selectBgView=nil;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark -
#pragma mark 屏幕点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userNameField resignFirstResponder];
    [userPswField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==userNameField)
    {
        [userPswField becomeFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [self loginButtonClicked:nil];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    return YES;
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
