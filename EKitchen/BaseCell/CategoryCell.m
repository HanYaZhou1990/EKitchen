//
//  CategoryCell.m
//  EKitchen
//
//  Created by hanyazhou on 15/3/4.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell ()  {
    UIImageView   *_headerImageView;
    UILabel       *_userNameLable;
    UIImageView   *_levelTypeImageView;
    UILabel       *_fractionLable;
    UILabel       *_distanceLable;
    UIImageView   *_userTypeImageView;
    UILabel       *_specialtyLable;
    UILabel       *_introductionLable;
}

@end

@implementation CategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 10, 88, 88)];
        _headerImageView.layer.cornerRadius = CGRectGetHeight(_headerImageView.frame)/2.0;
        _headerImageView.clipsToBounds = YES;
        [self.contentView addSubview:_headerImageView];
        
        
        _userNameLable = [[UILabel alloc] init];
        _userNameLable.font = [UIFont systemFontOfSize:17.0];
        [self.contentView addSubview:_userNameLable];
        
        
        _levelTypeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_levelTypeImageView];
        
        _fractionLable = [[UILabel alloc] init];
        _fractionLable.font = [UIFont systemFontOfSize:14.0];
        _fractionLable.textColor = UIColorFromRGB(0x3D3D3D);
        [self.contentView addSubview:_fractionLable];
        
        _distanceLable = [[UILabel alloc] init];
        _distanceLable.font = [UIFont systemFontOfSize:14.0];
        _distanceLable.textColor = UIColorFromRGB(0x666666);
        [self.contentView addSubview:_distanceLable];
        
        
        _userTypeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_userTypeImageView];
        
        
        _specialtyLable = [[UILabel alloc] init];
        _specialtyLable.font = [UIFont systemFontOfSize:14.0];
        _specialtyLable.textColor = UIColorFromRGB(0x666666);
        [self.contentView addSubview:_specialtyLable];
        
        _introductionLable = [[UILabel alloc] init];
        _introductionLable.font = [UIFont systemFontOfSize:12.0];
        _introductionLable.textColor = UIColorFromRGB(0x999999);
        _introductionLable.numberOfLines = 0;
        [self.contentView addSubview:_introductionLable];
        }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _headerImageView.image = _hederImage;
    
    /*用户名*/
    CGFloat width = [CalculationTool width:_userNameString heightOfFatherView:20 textFont:[UIFont systemFontOfSize:17.0]];
    if (width > 80.f) {
        _userNameLable.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, 10, 80, 20);
        _userNameLable.adjustsFontSizeToFitWidth = YES;
        _userNameLable.minimumFontSize = 10.0;
    }else {
        _userNameLable.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, 10, width, 20);
    }
    _userNameLable.text = _userNameString;
    
    
    _levelTypeImageView.frame = CGRectMake(CGRectGetMaxX(_userNameLable.frame)+10, 15, 12, 12);
    if (self.levelType == CategoryCellLevelTypePrimary) {
        _levelTypeImageView.image = [UIImage imageNamed:@"primary.png"];
    }else if (self.levelType == CategoryCellLevelTypeIntermediate){
        _levelTypeImageView.image = [UIImage imageNamed:@"intermediate.png"];
    }else {
        _levelTypeImageView.image = [UIImage imageNamed:@"advanced.png"];
    }
    
    /*分数*/
    CGFloat fractionWidth = [CalculationTool width:_fractionString heightOfFatherView:20 textFont:[UIFont systemFontOfSize:14.0]];
    _fractionLable.frame = CGRectMake(CGRectGetMaxX(_levelTypeImageView.frame)+10, 10, fractionWidth, 20);
    
    /*距离*/
    CGFloat distanceWidth = [CalculationTool width:_distanceString heightOfFatherView:20 textFont:[UIFont systemFontOfSize:14.0]];
    if (distanceWidth > 80) {
        distanceWidth = 80;
    }
    _distanceLable.frame = CGRectMake(SCREEN_WIDTH - 10 - distanceWidth, 10, distanceWidth, 20);
    _distanceLable.text = _distanceString;
    
    
    _fractionLable.text = _fractionString;
    
    _userTypeImageView.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, 40, 20, 12);
    if (self.userType == CategoryCellUserTypePersonal) {
        _userTypeImageView.image = [UIImage imageNamed:@"geren.png"];
    }else if (self.userType == CategoryCellUserTypeTeam){
        _userTypeImageView.image = [UIImage imageNamed:@"tuandui.png"];
    }else {
        _userTypeImageView.image = [UIImage imageNamed:@"tuandui.png"];
    }
    
    NSString *specialtyString = @"";
    for (NSString *string in _specialtyArray) {
        specialtyString = [specialtyString stringByAppendingString:[NSString stringWithFormat:@"%@ ",string]];
    }
    
    CGFloat specialtyWidth = [CalculationTool width:specialtyString heightOfFatherView:20 textFont:[UIFont systemFontOfSize:14.0]];
    _specialtyLable.frame = CGRectMake(CGRectGetMaxX(_userTypeImageView.frame)+10, 35, specialtyWidth, 20);
    _specialtyLable.text = specialtyString;
    
    _introductionLable.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame)+10, 60, SCREEN_WIDTH -(CGRectGetMaxX(_headerImageView.frame)+(10*2)) , 33);
    _introductionLable.text = _introductionString;
}
- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
