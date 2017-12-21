//
//  TSCCover.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/24.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCCover.h"
#import "TSCCoverElements.h"
@implementation TSCCover

-(void)setElements:(NSArray *)elements{
//    NSMutableArray *tempElements = [[NSMutableArray alloc]init];
//    for (NSDictionary *element in elements) {
//        TSCCoverElements *coverElement = [TSCCoverElements mj_objectWithKeyValues:element];
//        [tempElements addObject:coverElement];
//    }
    _elements = [TSCCoverElements mj_objectArrayWithKeyValuesArray:elements];
}
@end
