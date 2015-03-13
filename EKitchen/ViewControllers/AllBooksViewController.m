//
//  AllBooksViewController.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/14.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AllBooksViewController.h"

@interface AllBooksViewController () <UITableViewDataSource,UITableViewDelegate>{
    UITableView    *_booksTableView;
}
@end

@implementation AllBooksViewController

- (void)viewDidLoad {
    self.title = @"预订订单";
    [super viewDidLoad];
    
    _booksTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT - 44) style:UITableViewStyleGrouped];
    _booksTableView.delegate = self;
    _booksTableView.dataSource = self;
    _booksTableView.layer.borderWidth = 0.5;
    _booksTableView.layer.borderColor = UIColorFromRGB(0xCACACA).CGColor;
    [_booksTableView registerClass:[OpenHeaderView class] forHeaderFooterViewReuseIdentifier:@"openHeader"];
    [_booksTableView registerClass:[BookCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_booksTableView];
    
    
    UIButton *bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookButton setBackgroundColor:UIColorFromRGB(0xca1407)];
    [bookButton setTitleColor:UIColorFromRGB(0xF0F0F0) forState:UIControlStateNormal];
    bookButton.layer.cornerRadius = 2.0;
    bookButton.clipsToBounds = YES;
    [bookButton setTitle:@"立即预订" forState:UIControlStateNormal];
    [bookButton addTarget:self action:@selector(bookButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    bookButton.frame = CGRectMake(SCREEN_WIDTH - 128, SCREEN_HEIGHT - NAV_HEIGHT - 37, 118, 30);
    [self.view addSubview:bookButton];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OpenHeaderView *openView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openHeader"];
    openView.headerViewSection = section;
    openView.openHeaderViewType = OpenHeaderViewTypeNone;
    openView.contentString = @"共 9999 个订单 ";
    return openView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.userNameString = @"我是一个大厨神";
    cell.bookTimeString = @"2015-3-13 下午 2:00 - 5:30";
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate -

#pragma mark -
#pragma mark bookButtonClicked -
- (void)bookButtonClicked:(UIButton *)sender {
    BookViewController *bookVC= [[BookViewController alloc] init];
    [self.navigationController pushViewController:bookVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
