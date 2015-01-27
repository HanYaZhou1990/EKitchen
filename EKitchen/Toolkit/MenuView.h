//
//  MenuView.h
//  EKitchen
//
//  Created by Han_YaZhou on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuView;

#define ITEM_Width SCREEN_WIDTH/3
#define ITEM_Height 36
#define WIDTH_COUNT 3

@protocol MenuViewDelegate <NSObject>

@optional
- (void)itemClick:(MenuView *)view itemIndex:(NSInteger)index;

@end

@interface MenuView : UIView

/*!需要展示的对象*/
@property (nonatomic, strong) NSArray                *itemArray;
/*!代理 */
@property (nonatomic, assign) id<MenuViewDelegate>  delegate;

@end
