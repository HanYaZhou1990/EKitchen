//
//  CommentViewController.m
//  EKitchen
//
//  Created by julong on 15/1/29.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CommentViewController.h"
#import "CWStarRateView.h"

@interface CommentViewController ()<CWStarRateViewDelegate>
{
    NSArray *btnArray;
}
@end

@implementation CommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我要评论";
    
    [self leftBarItem];
    
    btnArray = @[@"饭菜很好吃",@"厨师很好",@"服务很好",@"厨师态度很不错"];
    
    if (btnArray.count>0)
    {
        [self setUseView];
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

#pragma mark -
#pragma mark 初始化各截面

-(void)setUseView
{
    //总体评价
    UILabel *overAllLabel = [[UILabel alloc]init];
    overAllLabel.frame = CGRectMake(10, 15, 80, 15);
    overAllLabel.textAlignment = NSTextAlignmentLeft;
    overAllLabel.textColor = [UIColor grayColor];
    overAllLabel.font = [UIFont systemFontOfSize:14];
    overAllLabel.text = @"总体评价:";
    overAllLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:overAllLabel];
    
    CWStarRateView *starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(90, 10, 100, 20) numberOfStars:5];
    starRateView.scorePercent = 0;
    starRateView.allowIncompleteStar = NO;
    starRateView.hasAnimation = NO;
    starRateView.isTap = YES;
    starRateView.delegate = self;
    [self.view addSubview:starRateView];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = RGBA(200, 200, 200, 1);
    lineLabel.frame = CGRectMake(0, 40, SCREEN_WIDTH, 1);
    [self.view addSubview:lineLabel];
    
    //具体评价
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.frame = CGRectMake(10, 50, 80, 15);
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.text = @"具体评价:";
    detailLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:detailLabel];
    
    //动态View
    UIView *btnView = [[UIView alloc]init];
    btnView.frame = CGRectMake(0, 70, SCREEN_WIDTH,100);
    [self.view addSubview:btnView];
    
    CGFloat heightUse = 0;
    
    CGRect frame = CGRectMake(0, 0, 0, 0);
    
    for (int i = 0; i<btnArray.count; i++)
    {
        NSString *btnTitle = [btnArray objectAtIndex:i];
        long lenth =  btnTitle.length;
        float width = lenth*17+20;
        
        int x1;
        int y;
        if ((frame.origin.x+frame.size.width+10+width)>SCREEN_WIDTH)
        {
            y=frame.origin.y+30+10;
            x1=10;
        }
        else
        {
            x1=frame.origin.x+frame.size.width+10;
            y = frame.origin.y;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.frame = CGRectMake(x1, y, width, 30);
        btn.tag = i+100;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setTitle:btnTitle forState:UIControlStateHighlighted];
        [btn setTitleColor:UIColorFromRGB(0xca1407) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4.0;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor =  UIColorFromRGB(0xca1407).CGColor;
        [btnView addSubview:btn];
        
        frame = btn.frame;
        
        CGFloat tempHeight = frame.size.height+frame.origin.y;
        if (tempHeight>heightUse)
        {
            heightUse = tempHeight;
        }
    }
        btnView.frame = CGRectMake(0, 70, SCREEN_WIDTH,heightUse+10);
    
        UILabel *lineTwoLabel = [[UILabel alloc]init];
        lineTwoLabel.backgroundColor = RGBA(200, 200, 200, 1);
        lineTwoLabel.frame = CGRectMake(0, btnView.frame.origin.y+btnView.frame.size.height, SCREEN_WIDTH, 1);
        [self.view addSubview:lineTwoLabel];
    
    
}

#pragma mark -
#pragma mark 点击事件
-(void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    DLog(@"评价按钮 %ld",(long)btn.tag);
}

#pragma mark -
#pragma mark CWStarRateViewDelegate
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    DLog(@"变值 = %f",newScorePercent);
    starRateView.scorePercent = 0;
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
