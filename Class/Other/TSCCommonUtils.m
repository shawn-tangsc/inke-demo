//
//  TSCCommonUtils.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/7.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCCommonUtils.h"
#import "AFNetworking.h"

@implementation TSCCommonUtils

+ (UIViewController *)superViewController:(UIViewController *)vc
{
    for (UIView* next = [vc.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (NSString *) getCurrentNetworkStatus{
    //报错Variable is not assignable (missing__block type specifier)
    //当在block内部使用block外部定义的局部变量时,如果变量没有被__block修饰,则在block内部是readonly(只读的),不能对他修改,如果想修改,变量前必须要有__block修饰,__block的作用告诉编译器,编译时在block内部不要把外部变量当做常量使用,还是要当做变量使用.如果再block中访问全局变量,就不需要__block修饰.
//    __block NSInteger *netStatus = nil;
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        netStatus = &status;
//    }];
//    return netStatus;
    
/*----------------------------------------------------------------------------------------------------------*/
    
    //不能在这里直接startMonitoring，因为这里是通过通过 SystemConfiguration 框架中的 SCNetworkReachability 来判断是否存在网络连接的，AFNetworkReachabilityManager 对象的 networkReachabilityStatus 属性值还是初始值 AFNetworkReachabilityStatusUnknown，直到异步线程中的 SCNetworkReachabilityGetFlags 函数返回，该属性值才能正确反映当前的网络状态
    //问题描述在： https://scfhao.coding.me/blog/2016/11/07/about-afnetworkreachibilymanager.html
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    NSString *status = [NSString stringWithFormat:@"%ld",(long)manager.networkReachabilityStatus];
    
    return status;
}
/**
 *  获取父视图的控制器
 *
 *  @return 父视图的控制器
 */

+ (UIViewController *)getSuperViewController:(NSString *)controllerName target:(nullable id)target{

    for (UIView* next = [target superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[controllerName class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
