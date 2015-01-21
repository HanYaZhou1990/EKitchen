//
//  HYZTextField.m
//  text
//
//  Created by Han_YaZhou on 15/1/17.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "HYZTextField.h"

@implementation HYZTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView =  leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();//获得处理上下文
    CGContextSetRGBStrokeColor(context, 151.0/255.0f, 151.0/255.0f, 151.0/255.0f, 1.0f);//设置线条颜色
                                                                                        //    下边的横线
    CGContextMoveToPoint(context, 0.5, rect.size.height - 0.5);//设置线的坐标点
    CGContextAddLineToPoint(context,rect.size.width - 0.5,rect.size.height - 0.5);//设置线的结束点
                                                                                  //    左边的竖线
    CGContextMoveToPoint(context, 0.5, rect.size.height/4*3);//设置线的坐标点
    CGContextAddLineToPoint(context, 0.5,rect.size.height - 0.5);//设置线的结束点
                                                                 //    右边的竖线
    CGContextMoveToPoint(context, rect.size.width - 0.5, rect.size.height/4*3);//设置线的坐标点
    CGContextAddLineToPoint(context,rect.size.width - 0.5,rect.size.height - 0.5);//设置线的结束点
    
    CGContextSetLineCap(context, kCGLineCapRound);//设置线条样式
    CGContextSetLineWidth(context, 0.5);//线的宽度
    CGContextStrokePath(context);//链接上边的坐标点
    [super drawRect:rect];
}
@end
