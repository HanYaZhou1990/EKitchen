//
//  MenuView.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "MenuView.h"

#define buttonWidth [[UIScreen mainScreen] bounds].size.width/3
#define buttonHeight 44
#define WIDTHCOUNT 3

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
        int x=(i%WIDTHCOUNT) + buttonWidth  * (i%WIDTHCOUNT);
        int y=(i/WIDTHCOUNT) + buttonHeight * (i/WIDTHCOUNT);
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=(i+1);
        [button setTitle:_itemArray[i] forState:UIControlStateNormal];
        button.frame=CGRectMake(x, y, buttonWidth, buttonHeight);
        [self addSubview:button];
        }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGFloat lengths[] = {4,4};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0.0, 44.0);
    CGContextAddLineToPoint(context, 320.0,44.0);
    
    CGContextMoveToPoint(context, 0.0, 88.0);
    CGContextAddLineToPoint(context, 320.0,88.0);
    
    CGContextMoveToPoint(context, 320.0/3, 0.0);
    CGContextAddLineToPoint(context, 320.0/3,44.0*3);
    
    CGContextMoveToPoint(context, 320.0/3*2, 0.0);
    CGContextAddLineToPoint(context, 320.0/3*2,44.0*3);
    
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

@end
