//
//  CommentTypeCell.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/12.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CommentTypeCell.h"

@interface CommentTypeCell () {
    NSMutableArray    *_buttonsArray;
}

@end

@implementation CommentTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _buttonsArray = [NSMutableArray array];
        for (int i=0; i<6; i++) {
                int x=i%3*((SCREEN_WIDTH - 24)/3) +i%3*6+6;
                int y=i/3*40 +i/3*8+8;
                
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(x, y, ((SCREEN_WIDTH - 24)/3), 40);
                btn.titleLabel.adjustsFontSizeToFitWidth = YES;
                btn.tag = i+10;
                btn.layer.borderWidth = 1.0;
                btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
                btn.layer.borderColor = UIColorFromRGB(0xca1407).CGColor;
                btn.contentEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
                [btn setTitleColor:UIColorFromRGB(0xca1407) forState:UIControlStateNormal];
                [btn setTitleColor:UIColorFromRGB(0xF0F0F0) forState:UIControlStateSelected];
                [btn setBackgroundImage:[UIImage initWithColor:UIColorFromRGB(0xca1407)] forState:UIControlStateSelected];
                [btn setBackgroundImage:[UIImage initWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0) {
                    btn.selected = YES;
                }
                [self.contentView addSubview:btn];
                [_buttonsArray addObject:btn];
            }
        }
    return self;
}

- (void)itemClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }else{
        for (int i = 0; i < _buttonsArray.count; i ++) {
            UIButton *btn = (UIButton *)_buttonsArray[i];
            if (sender.tag == btn.tag) {
                [btn setSelected:YES];
            }else{
                [btn setSelected:NO];
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < _itemArray.count; i ++) {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:i+10];
        [button setTitle:_itemArray[i] forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
