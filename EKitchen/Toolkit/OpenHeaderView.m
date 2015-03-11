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
    UIImageView *_statuesImageView;
    CWStarRateView *_starRateView;
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
        
        _statuesImageView = [[UIImageView alloc] init];
        _statuesImageView.image = [UIImage imageNamed:@"openItem.png"];
        [self addSubview:_statuesImageView];
        
        
        _starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 10, 120, 20) numberOfStars:5];
        _starRateView.allowIncompleteStar = NO;
        _starRateView.hasAnimation = NO;
        _starRateView.isTap = NO;
        [self addSubview:_starRateView];
        
        UITapGestureRecognizer *headerViewControl = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClicked:)];
        [self addGestureRecognizer:headerViewControl];
        }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _headerImageView.frame = CGRectMake(10, 7, 30, 30);
    
    if (_openHeaderViewType == OpenHeaderViewTypeOpenItem) {
        _statuesImageView.frame = CGRectMake(SCREEN_WIDTH - 40, 7, 30, 30);
        _starRateView.hidden = YES;
    }else {
        _statuesImageView.frame = CGRectZero;
    }
    
    if (_isOpen) {
        _statuesImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else {
        _statuesImageView.transform = CGAffineTransformMakeRotation(0);
    }
    
    _contentLable.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, 0, SCREEN_WIDTH/2-(CGRectGetMaxX(_headerImageView.frame)+10), CGRectGetHeight(self.frame));
    _contentLable.text = _contentString;
}

- (void)headerViewClicked:(UITapGestureRecognizer *)gestureRecognizer {
    if (_openHeaderViewType == OpenHeaderViewTypeStar) {
        return;
    }
    _isOpen =! _isOpen;
    
    if (_isOpen) {
        _statuesImageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else {
        _statuesImageView.transform = CGAffineTransformMakeRotation(0);
    }
    NSLog(@"+++++%d",_isOpen);
    if ([_delegate respondsToSelector:@selector(headerView:didSelected:)]) {
        [_delegate headerView:self didSelected:_isOpen];
    }
}

@end
