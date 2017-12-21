//
//  TSCCacheHelper.m
//  Test-inke
//  主要学习图片缓存
//  Created by 唐嗣成 on 2017/12/18.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCCacheHelper.h"
#import "TSCAdvertisingRecord.h"
static NSString *const adImageName = @"adImageName";
static NSString *const adURLName = @"adURLName";
static NSString *const adStart = @"adStart";
static NSString *const adEnd = @"adEnd";
static NSString *const adSkip = @"adSkip";
@implementation TSCCacheHelper

//+ (NSString *)getAdvertiseImage{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:adImageName];
//}
//
//+ (void) setAdvertiseImage : (NSString *)imageName{
//    [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:adImageName];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

//Preference 偏好存储
+ (TSCAdvertisingRecord *)getAdvertise{
    TSCAdvertisingRecord * record = [[TSCAdvertisingRecord alloc]init];
    record.img = [[NSUserDefaults standardUserDefaults] objectForKey:adImageName];
    record.url = [[NSUserDefaults standardUserDefaults] objectForKey:adURLName];
    record.dStart =[[[NSUserDefaults standardUserDefaults] objectForKey:adStart] integerValue];
    record.dEnd =[[[NSUserDefaults standardUserDefaults] objectForKey:adEnd] integerValue];
    record.skip =[[[NSUserDefaults standardUserDefaults] objectForKey:adSkip] isEqualToString:@"YES"]?YES:NO;
    return record;
}

+ (void) setAdvertiseRecord : (TSCAdvertisingRecord *)record{
    [[NSUserDefaults standardUserDefaults] setObject:record.img forKey:adImageName];
    [[NSUserDefaults standardUserDefaults] setObject:record.url forKey:adURLName];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%zd",record.dStart] forKey:adStart];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%zd",record.dEnd] forKey:adEnd];
    [[NSUserDefaults standardUserDefaults] setObject:record.skip?@"YES":@"NO" forKey:adSkip];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
