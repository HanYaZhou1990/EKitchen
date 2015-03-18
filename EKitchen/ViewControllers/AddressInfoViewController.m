//
//  AddressInfoViewController.m
//  EKitchen
//
//  Created by julong on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AddressInfoViewController.h"

@interface AddressInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *sectionOneArray;
    
    UITextField *userTextField;//姓名
    UITextField *phoneTextField;//手机号
    UITextField *areaTextField;//区域
    UITextField *addressTextField;//详细地址
}
@end

@implementation AddressInfoViewController
@synthesize _addressInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_addressInfo)
    {
        _addressInfo = [[AddressInfo alloc]init];
    }
    
    if ([self.typeStr isEqualToString:@"0"])
    {
        self.title = @"添加收货地址";
    }
    else if ([self.typeStr isEqualToString:@"1"])
    {
        self.title = @"编辑收货地址";
    }
    
    sectionOneArray = @[@"姓名",@"手机号",@"所在地区",@"详细地址"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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

//设置tableview属性
- (void)setTheTableView
{
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.tableFooterView = [UIView new];
    [self.view addSubview:myTableView];
}


-(void)rightButtonClick
{
    //验证姓名
    NSString *userAccount = [PublicConfig getUseStr:userTextField.text];
    if (userAccount==nil ||[userAccount isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"姓名不可为空"];
        return;
    }
    
    //验证手机号码
    NSString *phone = [PublicConfig getUseStr:phoneTextField.text];
    if (phone==nil ||[phone isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"手机号码不可为空"];
        return;
    }
    
    //验证地区
    NSString *area = [PublicConfig getUseStr:areaTextField.text];
    if (area==nil ||[area isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"地区不可为空"];
        return;
    }
    
    //验证详细地址
    NSString *address = [PublicConfig getUseStr:addressTextField.text];
    if (address==nil ||[address isEqualToString:@""])
    {
        [PublicConfig waringInfo:@"详细地址不可为空"];
        return;
    }
    
    //所有验证通过
    [self sendAddressData]; //发送注册请求
    
}
//发送添加地址或编辑请求 验证过不为空后发送
-(void)sendAddressData
{
    _addressInfo.userName = userTextField.text;
    _addressInfo.phoneNumber = phoneTextField.text;
    _addressInfo.area = areaTextField.text;
    _addressInfo.address = addressTextField.text;
    
    //刷新上一页表格
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sectionOneArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    //    if (cell==nil)
    //    {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    //    }
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 80, 20)];
    leftLabel.font = [UIFont systemFontOfSize:16];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:leftLabel];

        leftLabel.text = [sectionOneArray objectAtIndex:indexPath.row];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, SCREEN_WIDTH-100, 20)];
        textField.borderStyle = UITextBorderStyleNone;//无边框
        textField.font = [UIFont systemFontOfSize:14];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;//在编辑时出现x按钮
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母是否自动大写
        [textField setDelegate:self];
        [cell.contentView addSubview:textField];
        if (indexPath.row==0)
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyNext;
            userTextField = textField;
            if (_addressInfo.userName.length>0)
            {
                userTextField.text = _addressInfo.userName;
            }
        }
        else if (indexPath.row==1)
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyNext;
            phoneTextField = textField;
            if (_addressInfo.phoneNumber.length>0)
            {
                phoneTextField.text = _addressInfo.phoneNumber;
            }
        }
        else if (indexPath.row==2)
        {
            textField.enabled = NO;
            areaTextField = textField;
            if (_addressInfo.area.length>0)
            {
                areaTextField.text = _addressInfo.area;
            }
        }
        else if (indexPath.row==3)
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            addressTextField = textField;
            if (_addressInfo.address.length>0)
            {
                addressTextField.text = _addressInfo.address;
            }
        }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - UITextFieldDelegate

//email失去焦点，键盘消失
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //实现按键切换
    if (textField == userTextField)
    {
        [phoneTextField becomeFirstResponder];
    }
    if (textField == phoneTextField)
    {
        [userTextField resignFirstResponder];
        [phoneTextField resignFirstResponder];
        [areaTextField resignFirstResponder];
        [addressTextField resignFirstResponder];
    }
    if (textField == addressTextField)
    {
        [userTextField resignFirstResponder];
        [phoneTextField resignFirstResponder];
        [areaTextField resignFirstResponder];
        [addressTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    return YES;
}

#pragma mark -
#pragma mark 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [areaTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
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
