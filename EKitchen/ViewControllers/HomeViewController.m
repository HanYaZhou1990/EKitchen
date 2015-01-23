//
//  HomeViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"homeIconGray.png"] selectedImage:[UIImage imageNamed:@"homeIconRed.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    
    self.title = @"厨师之星";
    
    [self setTheTableView];
    
}

- (void)setTheTableView
{
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT) style:UITableViewStylePlain];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
    myTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSString *heasImageStr = @"http://img4.duitang.com/uploads/item/201404/15/20140415233353_WwtCY.thumb.700_0.jpeg";
    NSString *userNameStr = @"韩亚周";
    float score = 0.8;
    NSString *imgArrayStr = @"http://anhui.sinaimg.cn/2012/0708/U7657P1276DT20120708062608.jpg,http://pic20.nipic.com/20120424/8951495_172921455142_2.jpg,http://img.7808.cn/10/2012/0227/13303347573566.jpg,http://www.photophoto.cn/m77/161/006/1610060521.jpg";
    NSString *infoStr = @"川菜大师，有十年从业经验是一个很好的厨师，还会敲ios代码，装黑苹果。";
    NSString *cookStr = @"6768人预约过韩师傅";
    [cell setHeadImageStr:heasImageStr andUseName:userNameStr andScore:score andImgArray:imgArrayStr andInfo:infoStr andCook:cookStr andUseSign:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
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
