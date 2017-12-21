//
//  AppDelegate.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/21.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "AppDelegate.h"
#import "TSCTabBarViewController.h"
#import "TSCLocationManager.h"
#import "AFNetworking.h"
#import "TSCAdvertiseView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    TSCTabBarViewController * mainVC = [[TSCTabBarViewController alloc]init];
    
    self.window.rootViewController = mainVC;
    
    [[TSCLocationManager sharedManager]getGPS:^(NSString *lat, NSString *lon) {
        NSLog(@"经度%@,纬度：%@",lat,lon);
    }];
    //由于内部获取网络环境是异步的，在判断网络前，最好是应用一打开就要执行startMonitoring ，详情见TSCCommonUtils
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    TSCAdvertiseView * advertise = [[TSCAdvertiseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];;
    [self.window makeKeyAndVisible];//让window变成可见
    [self.window addSubview:advertise];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
