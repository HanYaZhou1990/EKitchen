//
//  ServiceTimeViewController.h
//  EKitchen
//
//  Created by Han_YaZhou on 15/3/13.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"

@class ServiceTimeViewController;

@protocol ServiceTimeViewControllerDelegate <NSObject>

- (void)viewController:(ServiceTimeViewController *)viewController serviceTime:(NSString *)timeString;

@end

@interface ServiceTimeViewController : BaseViewController

@property (nonatomic, assign) id <ServiceTimeViewControllerDelegate> delegate;

@end
