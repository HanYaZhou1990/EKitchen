//
//  RecommendCell.m
//  EKitchen
//
//  Created by hanyazhou on 15/1/27.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "RecommendCell.h"
@interface RecommendCell (){
    MenuView *itemView;
}
@end
@implementation RecommendCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
//        NSArray *array = @[@"粤菜",@"鲁菜",@"川菜",@"湘菜",@"闵菜",@"浙菜",@"苏菜",@"徽菜"];
//        itemView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ITEM_Height*ceil((double)array.count/WIDTH_COUNT))];
        itemView = [[MenuView alloc] init];
        itemView.backgroundColor = UIColorFromRGB(0xF0F0F0);
//        itemView.itemArray = array;
        [self.contentView addSubview:itemView];
        }
    return self;
}

- (void)layoutSubviews{
    itemView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ITEM_Height*ceil((double)_itemArray.count/WIDTH_COUNT));
    itemView.itemArray = _itemArray;
    [super layoutSubviews];
}
- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
