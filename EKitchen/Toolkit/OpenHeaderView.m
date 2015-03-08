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
        _contentLable = [[UILabel alloc] init];
        _contentLable.font = [UIFont systemFontOfSize:16.0];
        _contentLable.textColor = UIColorFromRGB(0x3D3D3D);
        [self addSubview:_contentLable];
        }
    return self;
}
@end
