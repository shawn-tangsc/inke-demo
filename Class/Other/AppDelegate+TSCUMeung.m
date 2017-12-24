//
//  AppDelegate+TSCUMeung.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/24.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "AppDelegate+TSCUMeung.h"
#import <UMSocialCore/UMSocialCore.h>
@implementation AppDelegate (TSCUMeung)
- (void) setupUmeng{
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"2892166685"];
    // 获取友盟social版本号
    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //各平台的详细配置
    //设置分享到QQ互联的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"100424468"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    // 如果不想显示平台下的某些类型(微信收藏)，可用以下接口设置
     [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
}
@end
