//
//  HomeCell.m
//  EKitchen
//
//  Created by julong on 15/1/22.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "HomeCell.h"
#import "CWStarRateView.h"
#import "UIImageView+WebCache.h"

@interface HomeCell()
{
    UIImageView     *headImageView;
    UILabel         *userNameLabel;
    CWStarRateView  *starRateView;
    UILabel         *scoreLabel;
    
    UIImageView     *oneImageView;
    UIImageView     *twoImageView;
    UIImageView     *threeImageView;
    UIImageView     *fourImageView;
    
    UILabel         *infoLabel;
    UILabel         *cookLabel;
    
}
@end

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds=YES;
        bgView.layer.borderWidth=0.5;
        bgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        bgView.frame = CGRectMake(5, 10, SCREEN_WIDTH-10, 200);
        [self.contentView addSubview:bgView];
        
        headImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 28, 28)];
        headImageView.layer.masksToBounds=YES;
        headImageView.layer.cornerRadius=14;
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:headImageView];
        
        userNameLabel = [[UILabel alloc]init];
        userNameLabel.frame = CGRectMake(40, 14, SCREEN_WIDTH-200, 15);
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        userNameLabel.textColor = [UIColor blackColor];
        userNameLabel.font = [UIFont systemFontOfSize:14];
        userNameLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:userNameLabel];
        
        starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 10, 100, 20) numberOfStars:5];
        starRateView.allowIncompleteStar = NO;
        starRateView.hasAnimation = NO;
        starRateView.isTap = NO;
        [bgView addSubview:starRateView];
        
        scoreLabel = [[UILabel alloc]init];
        scoreLabel.frame = CGRectMake(SCREEN_WIDTH-50, 14, 38, 15);
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.textColor = [UIColor blackColor];
        scoreLabel.font = [UIFont systemFontOfSize:14];
        scoreLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:scoreLabel];
        
        CGFloat useWidth = (SCREEN_WIDTH-10-288)/5;
        for (int i=0; i<4; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(72*i+useWidth*(i+1), 43, 72, 72);
//            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [bgView addSubview:imageView];
            if (i==0)
            {
                oneImageView = imageView;
            }
            else if (i==1)
            {
                twoImageView = imageView;
            }
            else if (i==2)
            {
                threeImageView = imageView;
            }
            else if (i==3)
            {
                fourImageView = imageView;
            }
        }
        
        infoLabel = [[UILabel alloc]init];
        infoLabel.frame = CGRectMake(5, 120, SCREEN_WIDTH-20, 40);
        infoLabel.textAlignment = NSTextAlignmentLeft;
        infoLabel.textColor = [UIColor grayColor];
        infoLabel.font = [UIFont systemFontOfSize:12];
        infoLabel.numberOfLines = 2;
        infoLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:infoLabel];
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = RGBA(200, 200, 200, 1);
        lineLabel.frame = CGRectMake(5, 160, SCREEN_WIDTH-20, 1);
        [bgView addSubview:lineLabel];
        
        cookLabel = [[UILabel alloc]init];
        cookLabel.frame = CGRectMake(10, 161, SCREEN_WIDTH-30, 39);
        cookLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:cookLabel];
    }
    return self;
}

- (void)setHeadImageStr:(NSString *)headImgStr  andUseName:(NSString *)useNameStr  andScore:(float)score andImgArray:(NSString *)imageArrayStr andInfo:(NSString *)infoStr andCook:(NSString *)cookStr andUseSign:(NSString *)useSign
{
    if (headImgStr==nil||[headImgStr isEqualToString:@""])
    {
        headImageView.image = [UIImage imageNamed:@"meBackground.png"];
    }
    else
    {
        NSString *__imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)headImgStr, nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"meBackground.png"];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:__imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL)
         {
         }];
    }
    
    userNameLabel.text = useNameStr;
    
    starRateView.scorePercent = score;
    
    NSString *startStr = [NSString stringWithFormat:@"%.0f分",starRateView.scorePercent*10];
    scoreLabel.text = startStr;
    
    if (imageArrayStr.length>0)
    {
         NSArray *imageArray = [imageArrayStr componentsSeparatedByString:@","];
        for (int i=0; i<imageArray.count; i++)
        {
            NSString *imageStr = [imageArray objectAtIndex:i];
            if (imageStr.length>0)
            {
                NSString *_imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)imageStr, nil, nil, kCFStringEncodingUTF8));
                UIImage *image = [UIImage imageNamed:@"meBackground.png"];
                if (i==0)
                {
                    [oneImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:image options:SDWebImageRefreshCached];
                }
                else if (i==1)
                {
                    [twoImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:image options:SDWebImageRefreshCached];
                }
                else if (i==2)
                {
                    [threeImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:image options:SDWebImageRefreshCached];
                }
                else if (i==3)
                {
                    [fourImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:image options:SDWebImageRefreshCached];
                }
            }
        }
    }
   
    infoLabel.text = infoStr;
    
    NSUInteger allLength = cookStr.length;
    NSString *stringBookCode = @"人预约";
    NSRange rangeBookCode = [cookStr rangeOfString:stringBookCode];
    if (rangeBookCode.location != NSNotFound)
    {
//        DLog(@"位置 location = %lu, length = %lu",(unsigned long)rangeBookCode.location,(unsigned long)rangeBookCode.length);
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cookStr];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xca1407) range:NSMakeRange(0,rangeBookCode.location)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(rangeBookCode.location,allLength-rangeBookCode.location)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0,rangeBookCode.location)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(rangeBookCode.location, allLength-rangeBookCode.location)];
        cookLabel.attributedText = str;
    }
    else
    {
        cookLabel.font = [UIFont systemFontOfSize:14];
        cookLabel.textColor = [UIColor grayColor];
        cookLabel.text = cookStr;
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
