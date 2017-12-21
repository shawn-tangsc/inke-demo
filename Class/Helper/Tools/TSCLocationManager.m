//
//  TSCLocationManager.m
//  Test-inke
//  工具类设计--》创建单例
//  单反工具类，初始化方法都会执行东西
//  Created by 唐嗣成 on 2017/12/2.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCLocationManager.h"
#import <CoreLocation/CoreLocation.h> //使用coreloaction 获取用户定位
@interface TSCLocationManager ()<CLLocationManagerDelegate> //?????
@property (nonatomic,strong) CLLocationManager * locManager;
@property (nonatomic,copy) locationBlock block; //为什么是copy
@end

@implementation TSCLocationManager

+ (instancetype)sharedManager{
    //gcd 实现单例
    static TSCLocationManager * _locationManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _locationManager = [[TSCLocationManager alloc]init];
        
    });
    return _locationManager;
}

//重写init方法
//还要改info.plist http://www.jianshu.com/p/f58be9373b6a
- (instancetype)init
{
    self = [super init];
    if (self) {
        _locManager = [[CLLocationManager alloc]init];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if(![CLLocationManager locationServicesEnabled]){
            NSLog(@"开启定位服务");
        } else {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if(status == kCLAuthorizationStatusNotDetermined){
                [_locManager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}
//实现delegate里的方法
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    CLLocationCoordinate2D coor = newLocation.coordinate;
    NSString *lat= [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString *lon= [NSString stringWithFormat:@"%@",@(coor.longitude)];
    //给block传值
    self.block(lat, lon);
    [TSCLocationManager sharedManager].lon = lon;
    [TSCLocationManager sharedManager].lat = lat;
    [self.locManager stopUpdatingLocation];
}

-(void)getGPS:(locationBlock)block{
    self.block = block;
    [self.locManager startUpdatingLocation];//??
}
@end
