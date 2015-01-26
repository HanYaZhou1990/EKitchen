//
//  AddressCell.m
//  EKitchen
//
//  Created by julong on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell()
{
    UILabel         *userNameLabel; //用户名手机号码
    UILabel         *addressLabel;  //地址
    
    UIButton        *selectBtn; //是否默认
    UIButton        *editBtn;
    UIButton        *deleteBtn;
    
}
@end

@implementation AddressCell
@synthesize addressDelegate = _addressDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds=YES;
        bgView.layer.borderWidth=0.5;
        bgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        bgView.frame = CGRectMake(5, 10, SCREEN_WIDTH-10, 114);
        [self.contentView addSubview:bgView];
        
        userNameLabel = [[UILabel alloc]init];
        userNameLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH-30, 15);
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        userNameLabel.textColor = [UIColor blackColor];
        userNameLabel.font = [UIFont systemFontOfSize:14];
        userNameLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:userNameLabel];
        
        addressLabel = [[UILabel alloc]init];
        addressLabel.frame = CGRectMake(userNameLabel.frame.origin.x, 30, userNameLabel.frame.size.width, 35);
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.font = [UIFont systemFontOfSize:12];
        addressLabel.numberOfLines = 2;
        addressLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:addressLabel];
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = RGBA(200, 200, 200, 1);
        lineLabel.frame = CGRectMake(0, 68, SCREEN_WIDTH-10, 0.5);
        [bgView addSubview:lineLabel];
        
        selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(10, 76, 31, 31);
        [selectBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOff.png"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOff.png"] forState:UIControlStateHighlighted];
        [selectBtn addTarget:self action:@selector(selectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:selectBtn];
        
        UILabel *setDefaultLabel = [[UILabel alloc]init];
        setDefaultLabel.frame = CGRectMake(45, 71, 100, 43);
        setDefaultLabel.textAlignment = NSTextAlignmentLeft;
        setDefaultLabel.textColor = [UIColor grayColor];
        setDefaultLabel.text = @"设为默认";
        setDefaultLabel.font = [UIFont systemFontOfSize:12];
        setDefaultLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:setDefaultLabel];
        
        editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.frame = CGRectMake(SCREEN_WIDTH-145, 76, 60, 31);
        [editBtn setBackgroundColor:[UIColor whiteColor]];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitle:@"编辑" forState:UIControlStateHighlighted];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [editBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        editBtn.layer.masksToBounds=YES;
        editBtn.layer.borderWidth=0.5;
        editBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:editBtn];
        
        deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH-75, 76, 60, 31);
        [deleteBtn setBackgroundColor:[UIColor whiteColor]];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitle:@"删除" forState:UIControlStateHighlighted];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        deleteBtn.layer.masksToBounds=YES;
        deleteBtn.layer.borderWidth=0.5;
        deleteBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:deleteBtn];
        
        
    }
    return self;
}

- (void)setUseNameStr:(NSString *)useNameStr  andAddressStr:(NSString *)addressStr andIsDefult:(BOOL)isDefult andRow:(NSInteger)row
{
    userNameLabel.text = useNameStr;
    addressLabel.text = addressStr;
    if (isDefult)
    {
        [selectBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOn.png"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOn.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [selectBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOff.png"] forState:UIControlStateNormal];
        [selectBtn setImage:[UIImage imageNamed:@"imageSelectedSmallOff.png"] forState:UIControlStateHighlighted];
    }
    
    editBtn.tag = row+100;
    deleteBtn.tag = row+10000;
    selectBtn.tag = row+20000;
}

//编辑按钮被点击
-(void)editBtnClicked:(id)sender
{
    [_addressDelegate editBtnClicked:sender];
}

//删除按钮被点击
-(void)deleteBtnClicked:(id)sender
{
     [_addressDelegate deleteBtnClicked:sender];
}

//设置默认按钮被点击
-(void)selectBtnClicked:(id)sender
{
    [_addressDelegate selectBtnClicked:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
