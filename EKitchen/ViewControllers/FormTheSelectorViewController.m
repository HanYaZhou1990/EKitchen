//
//  FormTheSelectorViewController.m
//  KH_MobileShop
//
//  Created by yons on 13-12-24.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "FormTheSelectorViewController.h"
#import "MessageSave.h"

@interface FormTheSelectorViewController ()

@end

@implementation FormTheSelectorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.titleStr;
    
    [self leftBarItem];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
  
}

- (void)leftBarItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0, 0, 29, 29);//图片宽29+5间隔 共40
    [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *leftBarBtnSpace = [PublicConfig setLeftBarBtnSpaceWidth];
    self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects:leftBarBtnSpace, leftBarButton, nil];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    if (indexPath.row !=self.dataSource.count-1)
    {
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 43.5, 310, 0.5)];
        lineLabel.backgroundColor = RGBA(191, 191, 191, 1);
        [cell addSubview:lineLabel];
    }
    
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [self.lastIndexPath row];
    cell.accessoryType = (row == oldRow && self.lastIndexPath != nil) ?
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    cell.backgroundColor = [UIColor whiteColor];
    return  cell;
    
}

#pragma -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger newRow = [indexPath row];
    NSInteger oldRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
    
    if (newRow != oldRow)
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                    indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                    self.lastIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        self.lastIndexPath = indexPath;
        
        //使用代理 实现传值
        
        MessageSave *mS = [MessageSave new];
        mS.indexPathRow = self.lastIndexPath.row;
        mS.titleString = self.titleStr;
        [self.formTheSelectorVCdelegate formTheSelectorMessage:mS];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
