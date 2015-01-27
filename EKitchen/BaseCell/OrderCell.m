//
//  OrderCell.m
//  EKitchen
//
//  Created by julong on 15/1/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "OrderCell.h"
#import "UIImageView+WebCache.h"

@interface OrderCell()
{
    UIImageView     *headImageView;//头像
    UILabel         *userNameLabel; //用户名
    UILabel         *packageLabel; //套餐种类和数量
    UILabel         *timeLabel; //套餐种类和数量
    UILabel         *addressLabel;  //地址
    
    UILabel         *moneyLabel;  //费用
    UILabel         *statusLabel;  //状态 等待开始 已完成
    UIButton        *payBtn;//支付
    UIButton        *commentBtn; //评论
    
}
@end

@implementation OrderCell
@synthesize orderDelegate = _orderDelegate;

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
        bgView.frame = CGRectMake(5, 10, SCREEN_WIDTH-10, 135);
        [self.contentView addSubview:bgView];
        
        headImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        headImageView.layer.masksToBounds=YES;
        headImageView.layer.cornerRadius=25;
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:headImageView];
        
        userNameLabel = [[UILabel alloc]init];
        userNameLabel.frame = CGRectMake(60, 10, SCREEN_WIDTH-80, 15);
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        userNameLabel.textColor = [UIColor blackColor];
        userNameLabel.font = [UIFont systemFontOfSize:14];
        userNameLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:userNameLabel];
        
        packageLabel = [[UILabel alloc]init];
        packageLabel.frame = CGRectMake(userNameLabel.frame.origin.x, userNameLabel.frame.size.height+userNameLabel.frame.origin.y+5, userNameLabel.frame.size.width, 15);
        packageLabel.textAlignment = NSTextAlignmentLeft;
        packageLabel.textColor = [UIColor grayColor];
        packageLabel.font = [UIFont systemFontOfSize:12];
        packageLabel.numberOfLines = 2;
        packageLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:packageLabel];
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.frame = CGRectMake(packageLabel.frame.origin.x, packageLabel.frame.size.height+packageLabel.frame.origin.y+5, packageLabel.frame.size.width, 15);
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:timeLabel];
        
        addressLabel = [[UILabel alloc]init];
        addressLabel.frame = CGRectMake(timeLabel.frame.origin.x, timeLabel.frame.size.height+timeLabel.frame.origin.y+5, timeLabel.frame.size.width, 15);
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.font = [UIFont systemFontOfSize:12];
        addressLabel.numberOfLines = 2;
        addressLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:addressLabel];
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = RGBA(200, 200, 200, 1);
        lineLabel.frame = CGRectMake(0, 90, SCREEN_WIDTH-10, 0.5);
        [bgView addSubview:lineLabel];
        
        moneyLabel = [[UILabel alloc]init];
        moneyLabel.frame = CGRectMake(10, 97, SCREEN_WIDTH-120, 31);
        moneyLabel.textAlignment = NSTextAlignmentRight;
        moneyLabel.textColor = [UIColor grayColor];
        moneyLabel.font = [UIFont systemFontOfSize:13];
        moneyLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:moneyLabel];
        moneyLabel.hidden = YES;
        
        payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(SCREEN_WIDTH-100, moneyLabel.frame.origin.y, 80, 31);
        [payBtn setBackgroundColor:RGBA(210, 6, 18, 1)];
        [payBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        [payBtn setTitle:@"立即付款" forState:UIControlStateHighlighted];
        payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        payBtn.layer.masksToBounds=YES;
        payBtn.layer.cornerRadius=4;
        [payBtn addTarget:self action:@selector(payBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:payBtn];
        payBtn.hidden = YES;
        
        statusLabel = [[UILabel alloc]init];
        statusLabel.frame = CGRectMake(0, moneyLabel.frame.origin.y, SCREEN_WIDTH-20, 31);
        statusLabel.textAlignment = NSTextAlignmentRight;
        statusLabel.textColor = [UIColor grayColor];
        statusLabel.font = [UIFont systemFontOfSize:13];
        statusLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:statusLabel];
        statusLabel.hidden = YES;
        
        commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commentBtn.frame = CGRectMake(SCREEN_WIDTH-100, moneyLabel.frame.origin.y, 80, 31);
        [commentBtn setBackgroundColor:RGBA(210, 6, 18, 1)];
        [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [commentBtn setTitle:@"评论" forState:UIControlStateHighlighted];
        commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        commentBtn.layer.masksToBounds=YES;
        commentBtn.layer.cornerRadius=4;
        [commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:commentBtn];
        commentBtn.hidden = YES;
        
    }
    return self;
}

- (void)setHeadImageStr:(NSString *)headImageStr andUseNameStr:(NSString *)useNameStr  andPackageTypeStr:(NSString *)packageTypeStr  andOrderTimeStr:(NSString *)orderTimeStr andOrderTypeStr:(NSString *)orderTypeStr andOrderAddressStr:(NSString *)orderAddressStr andOrderMoneyStr:(NSString *)orderMoneyStr andRow:(NSInteger)row
{
    if (headImageStr==nil||[headImageStr isEqualToString:@""])
    {
        headImageView.image = [UIImage imageNamed:@"meBackground.png"];
    }
    else
    {
        NSString *__imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)headImageStr, nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"meBackground.png"];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:__imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL)
         {
         }];
    }
    
    userNameLabel.text = useNameStr;
    packageLabel.text = packageTypeStr;
    timeLabel.text = orderTimeStr;
    addressLabel.text = orderAddressStr;
    statusLabel.textColor =[UIColor grayColor];
    payBtn.tag = row+10000;
    commentBtn.tag = row+20000;
    
    if ([orderTypeStr isEqualToString:@"0"])
    {
        //待付款
        moneyLabel.hidden = NO;
        moneyLabel.text = orderMoneyStr;
        payBtn.hidden = NO;
        statusLabel.hidden = YES;
        commentBtn.hidden = YES;   
    }
    else if ([orderTypeStr isEqualToString:@"1"])
    {
        //等待开始
        moneyLabel.hidden = YES;
        payBtn.hidden = YES;
        statusLabel.hidden = NO;
        statusLabel.text = @"等待开始";
        statusLabel.textColor =RGBA(210, 6, 18, 1);
        commentBtn.hidden = YES;
    }
    else if ([orderTypeStr isEqualToString:@"2"])
    {
        //待评论
        moneyLabel.hidden = YES;
        payBtn.hidden = YES;
        statusLabel.hidden = YES;
        commentBtn.hidden = NO;
    }
    else if ([orderTypeStr isEqualToString:@"3"])
    {
        //已完成
        moneyLabel.hidden = YES;
        payBtn.hidden = YES;
        statusLabel.hidden = NO;
        statusLabel.text = @"已完成";
        commentBtn.hidden = YES;
    }
    
    
}

//立即付款按钮被点击
-(void)payBtnClicked:(id)sender
{
    [_orderDelegate payBtnClicked:sender];
}

//评论按钮被点击
-(void)commentBtnClicked:(id)sender
{
    [_orderDelegate commentBtnClicked:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
