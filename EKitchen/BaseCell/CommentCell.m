//
//  CommentCell.m
//  EKitchen
//
//  Created by hanyazhou on 15/3/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell () {
    UILabel      *userNameLable;
    UILabel      *commentTimeLable;
    UILabel      *commentContentLable;
}

@end

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
        
        }
    return self;
}
- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
