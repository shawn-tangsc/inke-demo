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
#import "TSCLoginViewController.h"
#import "AppDelegate+TSCUMeung.h"
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 8.0) { // iOS8+ IconBadge需授权
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [self setupUmeng];
    UIViewController * mainVC ;
// 这里可以区分是否一定要进入login页面，我这里就偷个懒不做的那么细了，每次进入默认会进入
//     mainVC = [[TSCTabBarViewController alloc]init];
    mainVC = [[TSCLoginViewController alloc]init];
    
    self.window.rootViewController = mainVC;
    //获取用户的定位
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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
