//
//  TSCAdvertisingData.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCAdvertisingData.h"

@implementation TSCAdvertisingData

-(void)setRecord:(NSArray<TSCAdvertisingRecord *> *)record{
    _record = [TSCAdvertisingRecord mj_objectArrayWithKeyValuesArray:record];
}

@end
