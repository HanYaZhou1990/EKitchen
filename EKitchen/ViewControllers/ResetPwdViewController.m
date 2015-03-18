//
//  ResetPwdViewController.m
//  EKitchen
//
//  Created by julong on 15/1/21.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "HYZTextField.h"

@interface ResetPwdViewController ()<UITextFieldDelegate>
{
    HYZTextField *newPwdTextField;
    HYZTextField *confirmPwdTextField;
}
@end

@implementation ResetPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"重置密码";
    
    [self leftBarItem];
    
    [self setUseView];
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


#pragma mark -
#pragma mark 初始化界面

-(void)setUseView
{
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 30);
    headLabel.backgroundColor = [UIColor clearColor];
    headLabel.text = @"验证成功请输入新的密码";
    headLabel.textColor = [UIColor grayColor];
    headLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:headLabel];
    
    newPwdTextField = [[HYZTextField alloc]initWithFrame:CGRectMake(headLabel.frame.origin.x, headLabel.frame.size.height+headLabel.frame.origin.y+10, headLabel.frame.size.width, headLabel.frame.size.height)];
    newPwdTextField.placeholder = @"新密码";
    newPwdTextField.font = [UIFont systemFontOfSize:16];
    newPwdTextField.textColor = [UIColor blackColor];
    newPwdTextField.borderStyle = UITextBorderStyleNone;
    newPwdTextField.delegate =self;
    newPwdTextField.returnKeyType = UIReturnKeyNext;
    newPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    newPwdTextField.secureTextEntry = YES;//密码样式
    [self.view addSubview:newPwdTextField];
    
    confirmPwdTextField = [[HYZTextField alloc]initWithFrame:CGRectMake(newPwdTextField.frame.origin.x, newPwdTextField.frame.size.height+newPwdTextField.frame.origin.y+20, newPwdTextField.frame.size.width, newPwdTextField.frame.size.height)];
    confirmPwdTextField.placeholder = @"确认密码";
    confirmPwdTextField.font = [UIFont systemFontOfSize:16];
    confirmPwdTextField.textColor = [UIColor blackColor];
    confirmPwdTextField.borderStyle = UITextBorderStyleNone;
    confirmPwdTextField.delegate =self;
    confirmPwdTextField.returnKeyType = UIReturnKeyDone;
    confirmPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmPwdTextField.secureTextEntry = YES;//密码样式
    [self.view addSubview:confirmPwdTextField];
    
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(confirmPwdTextField.frame.origin.x, confirmPwdTextField.frame.size.height+confirmPwdTextField.frame.origin.y+30, confirmPwdTextField.frame.size.width, 50);
    [finishButton setBackgroundColor:RGBA(210, 6, 18, 1)];
    [finishButton setTitle:@"完  成" forState:UIControlStateNormal];
    [finishButton setTitle:@"完  成" forState:UIControlStateHighlighted];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    finishButton.layer.masksToBounds=YES;
    finishButton.layer.cornerRadius=4;
    [finishButton addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
}


#pragma mark -
#pragma mark 按钮点击事件

-(void)finishBtnClick
{
    //验证
    [newPwdTextField resignFirstResponder];
    [confirmPwdTextField resignFirstResponder];
    
    NSString *newPwdStr = [newPwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirmPwdStr = [confirmPwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (newPwdStr==nil||[newPwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"新密码不能为空"];
        [newPwdTextField becomeFirstResponder];
        return;
    }
    if (confirmPwdStr==nil||[confirmPwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"确认密码不能为空"];
        [confirmPwdTextField becomeFirstResponder];
        return;
    }
    if (![newPwdStr isEqualToString:confirmPwdStr])
    {
        [PublicConfig waringInfo:@"两次密码输入不一致"];
        return;
    }
    
    //验证后成功后发送请求
    [self sendChangePwdData:newPwdStr andConfirmPwd:confirmPwdStr];
    
}

//发送修改密码协议
-(void)sendChangePwdData:(NSString *)newPwd andConfirmPwd:(NSString *)confirmPwd
{
    
}

#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [newPwdTextField resignFirstResponder];
    [confirmPwdTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==newPwdTextField)
    {
        [confirmPwdTextField becomeFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [self finishBtnClick];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    return YES;
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
