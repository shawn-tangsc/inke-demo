//
//  TSCCacheHelper.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/18.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCAdvertisingRecord.h"
@interface TSCCacheHelper : NSObject

+ (TSCAdvertisingRecord *)getAdvertise;

+ (void) setAdvertiseRecord : (TSCAdvertisingRecord *)record;

@end
