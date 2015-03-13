//
//  CookerDetailViewController.h
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/6.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpandHeader.h"
#import "CookerHeaderView.h"
#import "CategoryCell.h"
#import "CookerTimeCell.h"
#import "OpenHeaderView.h"
#import "CommentCell.h"
#import "AllCommentsViewController.h"
#import "BookViewController.h"
#import "AllBooksViewController.h"

@interface CookerDetailViewController : BaseViewController<OpenHeaderViewDelegate,CookerHeaderViewDelegate> {
    BOOL             _isOpenSection[100];
}

@end
