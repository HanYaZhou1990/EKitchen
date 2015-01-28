//
//  AppDelegate.h
//  EKitchen
//
//  Created by julong on 15/1/16.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow     *window;

@property(nonatomic, strong) BMKMapManager *mapManager;

@end

