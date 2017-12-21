//
//  TSCHotSpecialData.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/16.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHotSpecialData.h"
#import "TSCTicker.h"
@implementation TSCHotSpecialData
-(void)setTicker:(NSArray *)ticker{
//    NSMutableArray *tempTicker = [[NSMutableArray alloc]init];
//    for (NSDictionary *data in ticker) {
//        TSCTicker *t = [TSCTicker mj_objectWithKeyValues:data];
//        [tempTicker addObject:t];
//    }
    _ticker = [TSCTicker mj_objectArrayWithKeyValuesArray:ticker];

}
@end
