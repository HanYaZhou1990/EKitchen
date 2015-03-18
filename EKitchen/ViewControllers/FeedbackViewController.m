//
//  FeedbackViewController.m
//  EKitchen
//
//  Created by julong on 15/1/21.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "FeedbackViewController.h"
#import "HYZTextField.h"

@interface FeedbackViewController ()<UITextFieldDelegate>
{
    HYZTextField          *feedField;
    HYZTextField          *phoneField;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    [self leftBarItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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

-(void)rightButtonClick
{
    [feedField resignFirstResponder];
    [phoneField resignFirstResponder];
    
    NSString *feedStr = [feedField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (feedStr==nil||[feedStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"反馈内容不能为空"];
        [feedField becomeFirstResponder];
        return;
    }
    
    NSString *phoneStr = [phoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phoneStr==nil||[phoneStr isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"联系方式不能为空"];
        [phoneField becomeFirstResponder];
        return;
    }
    
    [self sendFeedBackData];
}


#pragma mark -
#pragma mark 初始化界面

//初始化登陆界面
-(void)setUseView
{
    feedField = [[HYZTextField alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 30)];
    feedField.placeholder = @"您的意见...";
    feedField.font = [UIFont systemFontOfSize:16];
    feedField.textColor = [UIColor blackColor];
    feedField.borderStyle = UITextBorderStyleNone;
    feedField.delegate =self;
    feedField.returnKeyType = UIReturnKeyNext;
    [self.view addSubview:feedField];
    
    
    phoneField = [[HYZTextField alloc]initWithFrame:CGRectMake(feedField.frame.origin.x, feedField.frame.size.height+feedField.frame.origin.y+20, feedField.frame.size.width, feedField.frame.size.height)];
    phoneField.placeholder = @"您的姓名,手机号,QQ等";
    phoneField.font = [UIFont systemFontOfSize:16];
    phoneField.textColor = [UIColor blackColor];
    phoneField.borderStyle = UITextBorderStyleNone;
    phoneField.delegate =self;
    phoneField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:phoneField];
}

#pragma mark -
#pragma mark 协议实现

//提交意见反馈协议
-(void)sendFeedBackData
{
    //发送意见反馈协议
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark 屏幕点击事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [feedField resignFirstResponder];
    [phoneField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==feedField)
    {
        [phoneField becomeFirstResponder];
    }
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [self rightButtonClick];
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
