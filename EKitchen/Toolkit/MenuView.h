//
//  MenuView.h
//  EKitchen
//
//  Created by Han_YaZhou on 15/1/26.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ITEM_Width SCREEN_WIDTH/3
#define ITEM_Height 36
#define WIDTH_COUNT 3

@interface MenuView : UIView

/*!需要展示的对象*/
@property (nonatomic, strong) NSArray        *itemArray;

@end
