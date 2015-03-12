//
//  CookerHeaderView.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CookerHeaderView.h"

@interface CookerHeaderView (){
    UIButton     *_button;
}

@end

@implementation CookerHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
        {
        
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH, 40)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.3;
        [self addSubview:backView];
        _dishNameLable = [[UILabel alloc] init];
        _dishNameLable.textColor = UIColorFromRGB(0xF0F0F0);
        _dishNameLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dishNameLable];
        
        
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = UIColorFromRGB(0x3D3D3D);
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLable];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundColor:UIColorFromRGB(0xca1407)];
        [_button setTitleColor:UIColorFromRGB(0xF0F0F0) forState:UIControlStateNormal];
        _button.layer.cornerRadius = 2.0;
        _button.clipsToBounds = YES;
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        }
    return self;
}

- (void)buttonClicked:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(headerView:clickbutton:)]) {
        [_delegate headerView:self clickbutton:sender];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _dishNameLable.frame = CGRectMake(0, -40, SCREEN_WIDTH, 40);
    
    _titleLable.frame = CGRectMake(10, 12, SCREEN_WIDTH/2, 20);
    
    _button.frame = CGRectMake(SCREEN_WIDTH - 128, 7, 118, 30);
    [_button setTitle:_titleString forState:UIControlStateNormal];
}

@end
