//
//  OpenHeaderView.m
//  EKitchen
//
//  Created by hanyazhou on 15/3/7.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "OpenHeaderView.h"

@interface OpenHeaderView () {
    UILabel     *_contentLable;
}

@end

@implementation OpenHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
        {
        self.contentView.backgroundColor =[UIColor whiteColor];

        _headerImageView = [[UIImageView alloc] init];
        [self addSubview:_headerImageView];
        
        _contentLable = [[UILabel alloc] init];
        _contentLable.font = [UIFont systemFontOfSize:16.0];
        _contentLable.textColor = UIColorFromRGB(0x3D3D3D);
        [self addSubview:_contentLable];
        }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _headerImageView.frame = CGRectMake(10, 7, 30, 30);
    
    
    _contentLable.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, 0, SCREEN_WIDTH/2-(CGRectGetMaxX(_headerImageView.frame)+10), CGRectGetHeight(self.frame));
    _contentLable.text = _contentString;
}

@end
