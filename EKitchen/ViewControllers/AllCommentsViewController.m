//
//  AllCommentsViewController.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/12.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AllCommentsViewController.h"

@interface AllCommentsViewController () <UITableViewDataSource,UITableViewDelegate>{
    UITableView    *_commentsTableView;
}

@end

@implementation AllCommentsViewController

- (void)viewDidLoad {
    
    self.title = @"全部评论";
    
    [super viewDidLoad];
    
    
    _commentsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) style:UITableViewStyleGrouped];
    _commentsTableView.delegate = self;
    _commentsTableView.dataSource = self;
    [_commentsTableView registerClass:[OpenHeaderView class] forHeaderFooterViewReuseIdentifier:@"openHeader"];
    [_commentsTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
    [_commentsTableView registerClass:[CommentTypeCell class] forCellReuseIdentifier:@"CommentTypeCell"];
    [self.view addSubview:_commentsTableView];
}

#pragma mark -
#pragma mark UITableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        OpenHeaderView *openView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openHeader"];
        openView.headerViewSection = section;
        openView.openHeaderViewType = OpenHeaderViewTypeStar;
        openView.contentString = @"详细介绍";
        return openView;
    }else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CommentTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTypeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemArray = @[@"大家都说好(999999)",@"味道不错(1596)",@"非常好吃(22579)",@"经济实惠(59)",@"一般(1564)",@"很难吃(49687)",];
        return cell;
    }else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        cell.userNameString = @"看名字霸气不";
        cell.commentTimeString = @"2015-3-12";
        cell.commentContenString = @"做的饭很不错，很好吃哦，绝对的满分，好评，下次还请他!";
        return cell;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
