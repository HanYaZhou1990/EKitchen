//
//  MenuView.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
        {
        }
    return self;
}

- (void)layoutSubviews{
    for (int i=0; i<_itemArray.count; i++)
        {
        int x=(i%WIDTH_COUNT) + ITEM_Width  * (i%WIDTH_COUNT);
        int y=(i/WIDTH_COUNT) + ITEM_Height * (i/WIDTH_COUNT);
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=(i+1);
        [button setTitle:_itemArray[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x3D3D3D) forState:UIControlStateNormal];
        button.frame=CGRectMake(x, y, ITEM_Width, ITEM_Height);
        [self addSubview:button];
        }
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xCACACA).CGColor);
    CGFloat lengths[] = {4,4};
    CGContextSetLineDash(context, 0, lengths,2);
    /*列数*/
    int list = WIDTH_COUNT;
    /*行数*/
    int row = ceil((double)_itemArray.count/WIDTH_COUNT);
    /*余数*/
    int remainder = _itemArray.count%WIDTH_COUNT;
    /* 顶部和左侧都不需要虚线，所以从1开始*/
    for (int i = 1; i < list; i ++) {
        /*如果由三个或者三个以内的时候，这几项还是需要虚线分割开的，所以，必须从零开始*/
        for (int j = 0; j < row; j ++) {
            /*竖线*/
        CGContextMoveToPoint(context, SCREEN_WIDTH/WIDTH_COUNT*i, 0.0);
            /*整行多出来一个，和整行多出来两个的情况下*/
            if ((i == 1 && remainder == 1) || (i == 1 && remainder == 2)|| (i == 2 && remainder == 2) || remainder == 0) {
                CGContextAddLineToPoint(context, SCREEN_WIDTH/WIDTH_COUNT*i,ITEM_Height*(j + 1));
            }else {
                CGContextAddLineToPoint(context, SCREEN_WIDTH/WIDTH_COUNT*i,ITEM_Height*j);
            }
        }
        /*横线*/
        for (int k = 1; k < row; k ++ ) {
            CGContextMoveToPoint(context, 0.0, ITEM_Height*k);
            CGContextAddLineToPoint(context, SCREEN_WIDTH,ITEM_Height*k);
        }
    }
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

@end
