//
//  RegisterViewController.m
//  EKitchen
//
//  Created by julong on 15/1/19.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "RegisterViewController.h"
#import "HYZTextField.h"
#import "UserProtocolViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    HYZTextField *phoneTextField;
    HYZTextField *userPswField;
    HYZTextField *captchaTextField;
    
    UIButton *captchaBtn;
    UIButton *agreeBtn;
    BOOL isAgree;
    
   
}

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int miao;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"手机注册";
    
    [self leftBarItem];
    
    [self setUseView];
    
    isAgree = NO;
    
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
    phoneTextField = [[HYZTextField alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 30)];
    phoneTextField.backgroundColor = [UIColor clearColor];
    phoneTextField.textColor = [UIColor blackColor];
    phoneTextField.font = [UIFont systemFontOfSize:16];
    phoneTextField.placeholder = @"请输入手机号码";
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    phoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:phoneTextField];
    
    userPswField = [[HYZTextField alloc]initWithFrame:CGRectMake(phoneTextField.frame.origin.x, phoneTextField.frame.size.height+phoneTextField.frame.origin.y+20, phoneTextField.frame.size.width, phoneTextField.frame.size.height)];
    userPswField.placeholder = @"请输入密码";
    userPswField.font = [UIFont systemFontOfSize:16];
    userPswField.textColor = [UIColor blackColor];
    userPswField.borderStyle = UITextBorderStyleNone;
    userPswField.returnKeyType = UIReturnKeyDone;
    userPswField.delegate = self;
    userPswField.secureTextEntry = YES;//密码样式
    [self.view addSubview:userPswField];
    
    captchaTextField = [[HYZTextField alloc]initWithFrame:CGRectMake(userPswField.frame.origin.x, userPswField.frame.size.height+userPswField.frame.origin.y+20, SCREEN_WIDTH-60-120, userPswField.frame.size.height)];
    captchaTextField.backgroundColor = [UIColor clearColor];
    captchaTextField.textColor = UIColorFromRGB(0x9D9D9D);
    captchaTextField.font = [UIFont systemFontOfSize:16];
    captchaTextField.placeholder = @"验证码";
    captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    captchaTextField.autocapitalizationType = UITextAutocorrectionTypeNo;
    captchaTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    captchaTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:captchaTextField];
    
    captchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    captchaBtn.frame =CGRectMake(SCREEN_WIDTH-20-130, captchaTextField.frame.origin.y-10, 130, 40);
    [captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [captchaBtn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    captchaBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [captchaBtn setBackgroundImage:[UIImage imageNamed:@"captchBtn.png"] forState:UIControlStateNormal];
    [captchaBtn setBackgroundImage:[UIImage imageNamed:@"captchBtn.png"] forState:UIControlStateHighlighted];
    [captchaBtn addTarget:self action: @selector(captchaBtnClick) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:captchaBtn];
    
     UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(phoneTextField.frame.origin.x, captchaTextField.frame.size.height+captchaTextField.frame.origin.y+30, phoneTextField.frame.size.width, 50);
    [registerButton setBackgroundColor:RGBA(210, 6, 18, 1)];
    [registerButton setTitle:@"注  册" forState:UIControlStateNormal];
    [registerButton setTitle:@"注  册" forState:UIControlStateHighlighted];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    registerButton.layer.masksToBounds=YES;
    registerButton.layer.cornerRadius=4;
    [registerButton addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(phoneTextField.frame.origin.x, registerButton.frame.size.height+registerButton.frame.origin.y+10, 20, 20);
    [agreeBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOff.png"]forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeBtn];
    
    UILabel *agreeLabel = [[UILabel alloc]init];
    agreeLabel.frame = CGRectMake(agreeBtn.frame.size.width+agreeBtn.frame.origin.x+5, agreeBtn.frame.origin.y, 180, 20);
    agreeLabel.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"我同意e厨一味的用户协议"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,9)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, 9)];
    agreeLabel.attributedText = str;
    [self.view addSubview:agreeLabel];
    
    
    UIButton *useAgreeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    useAgreeBtn.backgroundColor = [UIColor clearColor];
    useAgreeBtn.frame = CGRectMake(agreeLabel.frame.origin.x+40,agreeLabel.frame.origin.y, agreeLabel.frame.size.width-40, 20);
    [useAgreeBtn addTarget:self action:@selector(useAgreeBtnBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:useAgreeBtn];
    
   
}

-(void)onTimer
{
    self.miao--;
    NSString *captchBtnStr;
    
    if (self.miao==0)
    {
        captchBtnStr = @"重新获取验证码";
        [self.timer invalidate];
        captchaBtn.userInteractionEnabled = YES;
    }
    else
    {
        captchBtnStr = [NSString stringWithFormat:@"(%ds)重新获取验证码",self.miao];
        captchaBtn.userInteractionEnabled = NO;
    }
    [captchaBtn setTitle:captchBtnStr forState:UIControlStateNormal];
    [captchaBtn setTitle:captchBtnStr forState:UIControlStateHighlighted];
}

#pragma mark -
#pragma mark 按钮点击事件
//同意或不同意用户协议
-(void)agreeBtnBtnClick
{
    isAgree = !isAgree;
    if (isAgree)
    {
        [agreeBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOn.png"]forState:UIControlStateNormal];
    }
    else
    {
        [agreeBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOff.png"]forState:UIControlStateNormal];
    }
}

//用户协议
-(void)useAgreeBtnBtnBtnClick
{
    UserProtocolViewController *vc = [[UserProtocolViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//获取验证码
-(void)captchaBtnClick
{
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    
    NSString *phoneStr = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"手机号码不能为空"];
        [phoneTextField becomeFirstResponder];
        return;
    }
    else
    {
        //手机号码2
        BOOL isUsed = [self validateMobile:phoneStr];
        if (isUsed==NO)
        {
            [PublicConfig waringInfo:@"手机号码格式不正确"];
            [phoneTextField becomeFirstResponder];
            captchaTextField.text = nil;
            return;
        }
    }

    //获取校验码
    [self getValidCodeData:phoneStr];
    
    self.miao = 60;
    if (self.timer)
    {
        [self.timer invalidate];
    }
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES ];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//注册
-(void)registerBtnClick
{
    //发送注册请求 请求成功返回
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [userPswField resignFirstResponder];
    
    NSString *phoneStr = [phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *pwdStr = [userPswField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *captchaStr = [captchaTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"手机号码不能为空"];
        [phoneTextField becomeFirstResponder];
        return;
    }
    else
    {
        //手机号码2
        BOOL isUsed = [self validateMobile:phoneStr];
        if (isUsed==NO)
        {
            [PublicConfig waringInfo:@"手机号码格式不正确"];
            [phoneTextField becomeFirstResponder];
            captchaTextField.text = nil;
            return;
        }
    }
    
    if (pwdStr==nil||[pwdStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"密码不能为空"];
        [userPswField becomeFirstResponder];
        return;
    }
    
    if (captchaStr==nil||[captchaStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"验证码不能为空"];
        [captchaTextField becomeFirstResponder];
        return;
    }
    
    if (!isAgree)
    {
        [PublicConfig waringInfo:@"请您选择同意用户协议"];
        return;
    }
    //验证后成功后发送请求
    [self registerUserData:phoneStr andPassWord:captchaStr];
    
}

//手机号码验证
- (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark -
#pragma mark 请求相关

//注册请求
-(void)registerUserData:(NSString *)userName andPassWord:(NSString *)passWord
{
    
}

//给用户发送短信验证码
-(void)getValidCodeData:(NSString *)hp
{
    
}

#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [captchaTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [userPswField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
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
