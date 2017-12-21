//
//  NSString+CachePath.m
//  Test-inke
//  委托nsstirng
//  Created by 唐嗣成 on 2017/12/18.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "NSString+CachePath.h"

@implementation NSString (CachePath)
-(NSString *) cacheWithPath{
    NSString * sandbox = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];//???
    return [sandbox stringByAppendingPathComponent:self];
}
@end
