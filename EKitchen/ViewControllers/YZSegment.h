//
//  YZSegment.h
//  CustomSegment
//
//  Created by hanyazhou on 15/1/21.
//  Copyright (c) 2015年 HYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@class YZSegmentButton;

@protocol YZSegmentDelegate <NSObject>

@required
- (void)view:(UIScrollView *)view didSelectIndex:(NSInteger)indexOfButton;

@end

@interface YZSegment : UIScrollView

@property (nonatomic, assign) id <YZSegmentDelegate> myDelegate;

/*!
 btnInformation  每项的title
 offSet          偏移到第几项
 */
- (id)initWithFrame:(CGRect)frame
     btnInformation:(NSArray *)btnInformation
      contentOffSet:(NSInteger)offSet;

+ (UIScrollView *)shareScrollView;

@end

@interface YZSegmentButton : UIButton

@end