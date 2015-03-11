//
//  CommentCell.h
//  EKitchen
//
//  Created by hanyazhou on 15/3/11.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

/*!评论展示*/
@interface CommentCell : UITableViewCell

/*!评论人用户名*/
@property (nonatomic, strong) NSString         *userNameString;
/*!评论时间*/
@property (nonatomic, strong) NSString         *commentTimeString;
/*!评论星级*/
@property (nonatomic, strong) CWStarRateView   *commentStarView;
/*!评论内容*/
@property (nonatomic, strong) NSString         *commentContenString;

@end
