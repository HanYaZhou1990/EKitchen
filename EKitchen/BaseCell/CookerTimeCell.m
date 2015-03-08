//
//  CookerTimeCell.m
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "CookerTimeCell.h"

@interface CookerTimeCell () {
    UIImageView             *_timeImageView;
    UIImageView             *_addressImageView;
    UILabel                 *_workTimeLable;
    UILabel                 *_addressLable;
}

@end

@implementation CookerTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        {
        _timeImageView = [[UIImageView alloc] init];
        _timeImageView.bounds = CGRectMake(0, 0, 29, 29);
        _timeImageView.image = [UIImage imageNamed:@"time.png"];
        [self.contentView addSubview:_timeImageView];
        
        _addressImageView = [[UIImageView alloc] init];
        _addressImageView.bounds = CGRectMake(0, 0, 29, 29);
        _addressImageView.image = [UIImage imageNamed:@"locationItem.png"];
        [self.contentView addSubview:_addressImageView];
        
        
        _workTimeLable = [[UILabel alloc] init];
        _workTimeLable.font = [UIFont systemFontOfSize:14.0];
        _workTimeLable.textColor = UIColorFromRGB(0x999999);
        _workTimeLable.numberOfLines = 0;
        _workTimeLable.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_workTimeLable];
        
        _addressLable = [[UILabel alloc] init];
        _addressLable.font = [UIFont systemFontOfSize:14.0];
        _addressLable.textColor = UIColorFromRGB(0x999999);
        _addressLable.numberOfLines = 0;
        [self.contentView addSubview:_addressLable];
        
        }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat currentHeight = CGRectGetHeight(self.frame)/4;
    _timeImageView.center = CGPointMake(54/2, currentHeight);
    _addressImageView.center = CGPointMake(54/2, currentHeight*3);
    
    NSString *timeString = @"";
    for (int i = 0; i < _workDayArray.count; i ++) {
        if (i == _workDayArray.count - 1) {
            timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%@",_workDayArray[i]]];
        }else {
            timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%@\n",_workDayArray[i]]];
        }
    }
    _workTimeLable.frame = CGRectMake(54+10, 0, SCREEN_WIDTH - 74, currentHeight*2);
    _workTimeLable.text = timeString;
    
    _addressLable.frame = CGRectMake(54+10, currentHeight*2+10, SCREEN_WIDTH - 74, currentHeight*4-(currentHeight*2+10)-10);
    _addressLable.text = _addressString;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xCACACA).CGColor);
    CGFloat lengths[] = {4,4};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 54.0, 0.0);
    CGContextAddLineToPoint(context, 54.0,rect.size.height);
    CGContextMoveToPoint(context, 0.0, rect.size.height/2);
    CGContextAddLineToPoint(context, SCREEN_WIDTH,rect.size.height/2);
    CGContextDrawPath(context, kCGPathEOFillStroke);
}

- (void)awakeFromNib {}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
