//
//  TSCAdvertisingData.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCAdvertisingRecord.h"

@interface TSCAdvertisingData : NSObject
@property (nonatomic, strong) NSString * md5;
@property (nonatomic, strong) NSArray<TSCAdvertisingRecord *> * record;
@end
