//
//  LazyViewController.h
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "BaseViewController.h"
#import "BMapKit.h"

@interface LazyViewController : BaseViewController<BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView;

@end
