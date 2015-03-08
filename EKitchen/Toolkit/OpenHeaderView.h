//
//  OpenHeaderView.h
//  EKitchen
//
//  Created by hanyazhou on 15/3/7.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OpenHeaderViewStateTypeClose,
    OpenHeaderViewStateTypeOpen,
    
}OpenHeaderViewStateType;

@interface OpenHeaderView : UITableViewHeaderFooterView

/*!前边的图片*/
@property (nonatomic, readonly) UIImageView *headerImageView;
/*!图片后的文字内容*/
@property (nonatomic, retain) NSString    *contentString;
/*!展开和闭合状态（尾部的图片，可以旋转的）*/
@property (nonatomic, assign) BOOL          isOpen;

@end
