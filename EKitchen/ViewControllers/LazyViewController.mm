//
//  LazyViewController.m
//  EKitchen
//
//  Created by julong on 15/1/17.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "LazyViewController.h"

@interface LazyViewController () {
    NSArray      *_arrayX;
    NSArray      *_arrayY;
}

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
    
    _arrayX = @[@"34.834775",@"34.804775",@"34.854775",@"34.884775",@"34.904775"];
    _arrayY = @[@"113.800128",@"113.700128",@"113.610128",@"113.650128",@"113.680128"];
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-TAB_HEIGHT)];
    self.view = _mapView;
    
    /*模拟*/
    [self performSelector:@selector(addPointe) withObject:self afterDelay:3.0];
    
    
        //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
        //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
        //启动LocationService
    [_locService startUserLocationService];
}

- (void)addPointe {
    [self addPointAnnotation];
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//    [alert show];
//    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

    //添加标注
- (void)addPointAnnotation
{
    for (int i = 0; i <5; i ++) {
        BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [_arrayX[i] doubleValue];
        coor.longitude = [_arrayY[i] doubleValue];
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"test";
        pointAnnotation.subtitle = @"此Annotation可拖拽!";
        [_mapView addAnnotation:pointAnnotation];
    }
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"renameMark";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
        annotationView.image = [UIImage imageNamed:@"aboutMeItem"];
        annotationView.layer.cornerRadius = CGRectGetHeight(annotationView.frame)/2;
        annotationView.clipsToBounds = YES;
    }
    return annotationView;
}

#pragma mark - BMKLocationServiceDelegate
    //实现相关delegate 处理位置信息更新
    //处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
    //处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (userLocation) {
        [_locService stopUserLocationService];
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        _mapView.showsUserLocation = YES;//显示定位图层
        [_mapView updateLocationData:userLocation];
        _mapView.centerCoordinate = userLocation.location.coordinate;
    }
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
