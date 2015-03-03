//
//  AppDelegate.m
//  EKitchen
//
//  Created by julong on 15/1/16.
//  Copyright (c) 2015年 renbing. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "YYDes.h"
#import "AFNetworking.h"
#import <AdSupport/ASIdentifierManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)test{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStampString = [NSString stringWithFormat:@"%.f",timeStamp];
    
    /*! 假如mobile 是   13598084041*/
    NSString *mobileString = @"13598084041";
    
    /*因为密码需要经过DES加密，所以需要先取key,key是手机号的前八位*/
    NSString *key = [mobileString substringToIndex:8];
    /*!假如密码是  123456*/
    NSString *passwordString = [YYDes DESEncrypt:[@"123456" dataUsingEncoding:NSUTF8StringEncoding] WithKey:key];
    
    NSDictionary *parameters = @{@"appKey":appKeyEkitchen,@"method":@"member.login",@"v":versionEkitchen,@"format":formatEkitchen,@"locale":localeEkitchen,@"timestamp":timeStampString,@"mobile":mobileString,@"client":clientEkitchen};
    
    NSDictionary *dic = @{@"appKey":appKeyEkitchen,@"method":@"member.login",@"v":versionEkitchen,@"format":formatEkitchen,@"locale":localeEkitchen,@"timestamp":timeStampString,@"mobile":mobileString,@"client":clientEkitchen,@"password":passwordString,@"sign":[YYDes generate:parameters],@"identify":[[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""]};
        //    http://zzbaoyuan.f3322.org:8089/api
    [manager POST:BASE_PLAN_URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json = %@",responseObject);
        NSLog(@"message = %@",responseObject[@"message"]);
        NSLog(@"solution = %@",responseObject[@"solution"]);
        NSLog(@"%@     +++    %@",responseObject[@"subErrors"][0][@"message"],responseObject[@"subErrors"][0][@"code"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"**************** = %@",error);
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self test];
    
        // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"pshbDYQ3EmjvwmLUeCPOT3vf" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES]; //偏移
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xca1407)];//设置导航栏背景颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    if (IOS7)
    {
        //标题颜色
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                               nil, NSShadowAttributeName,
                                                               [UIFont systemFontOfSize:10], NSFontAttributeName, nil]];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootTabBarViewController *rootViewController = [[RootTabBarViewController alloc] init];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    controller.navigationBarHidden = YES;
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
