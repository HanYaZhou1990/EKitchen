//
//  HomeCell.m
//  EKitchen
//
//  Created by julong on 15/1/22.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell()
{
    UILabel         *titleLabel;
}
@end

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
