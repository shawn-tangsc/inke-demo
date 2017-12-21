//
//  TSCExtra.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/23.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCExtra.h"
#import "TSCLabel.h"
@implementation TSCExtra

-(void)setLabel:(NSArray<TSCLabel *> *)label{
    _label = [TSCLabel mj_objectArrayWithKeyValuesArray:label];
}
@end
