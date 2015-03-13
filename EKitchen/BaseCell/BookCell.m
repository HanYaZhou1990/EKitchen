//
//  BookCell.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/14.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BookCell.h"

@interface BookCell () {
    UILabel      *_userNameLable;
    UIImageView  *_timeImageView;
    UILabel      *_bookTimeLable;
}

@end

@implementation BookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _userNameLable = [[UILabel alloc] init];
        _userNameLable.font = [UIFont systemFontOfSize:14.0];
        _userNameLable.textColor = UIColorFromRGB(0x3d3d3d);
        [self.contentView addSubview:_userNameLable];
        
        _timeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time.png"]];
        [self.contentView addSubview:_timeImageView];
        
        _bookTimeLable = [[UILabel alloc] init];
        _bookTimeLable.font = [UIFont systemFontOfSize:14.0];
        _bookTimeLable.textColor = UIColorFromRGB(0x666666);
        [self.contentView addSubview:_bookTimeLable];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.frame);
    
    _userNameLable.frame = CGRectMake(10, 0, 100, height);
    _userNameLable.text = _userNameString;
    
    _timeImageView.frame = CGRectMake(CGRectGetMaxX(_userNameLable.frame)+5, 16, 32, 32);
    
    CGFloat timeWith = SCREEN_WIDTH - CGRectGetMaxX(_timeImageView.frame) - 30;
    _bookTimeLable.frame = CGRectMake(SCREEN_WIDTH - timeWith - 15, 0, timeWith, height);
    _bookTimeLable.text = _bookTimeString;
    
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
