//
//  PackageViewController.h
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"

@class PackageViewController;

@protocol PackageViewControllerDelegate <NSObject>

- (void)viewController:(PackageViewController *)viewController package:(NSString *)packageString;

@end

@interface PackageViewController : BaseViewController

@property (nonatomic, assign) id <PackageViewControllerDelegate> delegate;

@end
