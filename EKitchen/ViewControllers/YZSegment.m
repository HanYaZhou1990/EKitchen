//
//  YZSegment.m
//  CustomSegment
//
//  Created by hanyazhou on 15/1/21.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import "YZSegment.h"

@interface YZSegment () {
    NSMutableArray       *__btnArray;
}

@end

@implementation YZSegment

- (id)initWithFrame:(CGRect)frame btnInformation:(NSArray *)btnInformation contentOffSet:(NSInteger)offSet{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColorFromRGB(0xC8C7CC) CGColor];
        self.layer.borderWidth = 0.5;
        self.showsHorizontalScrollIndicator = NO;
        [self drawUIWithArray:btnInformation rect:frame contentOffSet:offSet];
    }
    return self;
}

- (void)drawUIWithArray:(NSArray *)informationArrry rect:(CGRect)rect contentOffSet:(NSInteger)offSet{
    if (!__btnArray) {
        __btnArray = [@[]mutableCopy];
    }
    for (int i = 0; i < informationArrry.count; i ++) {
        YZSegmentButton *button = [YZSegmentButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(rect.size.width/informationArrry.count*i, 0, rect.size.width/informationArrry.count, rect.size.height);
        [button setTitle:informationArrry[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xCA1407) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setMultipleTouchEnabled:YES];
        if (i == offSet) {button.selected = YES;}
        button.tag = i +10;
        [__btnArray addObject:button];
        [self addSubview:button];
    }
}

-(void)itemClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }else{
        for (int i = 0; i < __btnArray.count; i ++) {
            UIButton *btn = (UIButton *)__btnArray[i];
            if (sender.tag == btn.tag) {
                [btn setSelected:YES];
                if ([_myDelegate respondsToSelector:@selector(view:didSelectIndex:)]) {
                    [_myDelegate view:self didSelectIndex:sender.tag-10];
                }
            }else{
                [btn setSelected:NO];
            }
        }
    }
}

static UIScrollView* shareScroll = nil;
+(UIScrollView *)shareScrollView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareScroll = [[self alloc] init];
    });
    return shareScroll;
}

@end

@implementation YZSegmentButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 1, self.frame.size.height-16)];
    line.backgroundColor = UIColorFromRGB(0xC8C7CC);
    [self addSubview:line];
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.selected) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height-2, rect.size.width, 2)];
        view.backgroundColor = UIColorFromRGB(0xCA1407);
        [self addSubview:view];
    }else{
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIView class]]) {
                view.frame = CGRectZero;
            }
        }
    }
}
@end
