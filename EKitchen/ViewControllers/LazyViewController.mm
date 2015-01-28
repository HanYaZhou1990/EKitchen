//
//  LazyViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "LazyViewController.h"

@interface LazyViewController ()

@end

@implementation LazyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
     self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"懒人" image:[UIImage imageNamed:@"lazyIconGray.png"] selectedImage:[UIImage imageNamed:@"lazyIconRed.png"]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"懒人";
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT)];
    self.view = _mapView;
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alert show];
    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
