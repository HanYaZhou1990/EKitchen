//
//  CommentCell.m
//  EKitchen
//
//  Created by hanyazhou on 15/3/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell () {
    UILabel      *_userNameLable;
    UILabel      *_commentTimeLable;
    UILabel      *_commentContentLable;
}

@end

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
        _userNameLable = [[UILabel alloc] init];
        _userNameLable.font = [UIFont systemFontOfSize:15.0];
        _userNameLable.textColor = UIColorFromRGB(0x3D3D3D);
        [self.contentView addSubview:_userNameLable];
        
        
        _commentTimeLable = [[UILabel alloc] init];
        _commentTimeLable.font = [UIFont systemFontOfSize:12.0];
        _commentTimeLable.textColor = UIColorFromRGB(0x999999);
        _commentTimeLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_commentTimeLable];
        
        _commentStarView = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 4, 88, 20)];
        [self.contentView addSubview:_commentStarView];
        
        
        _commentContentLable = [[UILabel alloc] init];
        _commentContentLable.font = [UIFont systemFontOfSize:14.0];
        _commentContentLable.textColor = UIColorFromRGB(0x666666);
        _commentContentLable.numberOfLines = 0;
        [self.contentView addSubview:_commentContentLable];
        
        }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat nameWidth = [PublicConfig width:_userNameString heightOfFatherView:20 textFont:[UIFont systemFontOfSize:15.0]];
    if (nameWidth > 120) {
        nameWidth = 120;
    }
    _userNameLable.frame = CGRectMake(10, 4, nameWidth, 20);
    _userNameLable.text = _userNameString;
    
    _commentTimeLable.frame = CGRectMake(CGRectGetMaxX(_userNameLable.frame), 4, 80, 20);
    _commentTimeLable.text = _commentTimeString;
    
    CGFloat contentHeight = [PublicConfig height:_commentContenString widthOfFatherView:SCREEN_WIDTH-20 textFont:[UIFont systemFontOfSize:14.0]];
    if (contentHeight > CGRectGetHeight(self.frame)-30) {
        contentHeight = CGRectGetHeight(self.frame)-30;
    }
    _commentContentLable.frame = CGRectMake(10, CGRectGetMaxY(_userNameLable.frame)+4, SCREEN_WIDTH-20, contentHeight);
    _commentContentLable.text = _commentContenString;
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
