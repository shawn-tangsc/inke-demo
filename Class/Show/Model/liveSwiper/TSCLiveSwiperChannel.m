//
//  TSCLiveSwiperChannel.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/16.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCLiveSwiperChannel.h"
#import "TSCCards.h"
#import "TSCLive.h"
#import "TSCLiveSwiperChannelResource.h"
@implementation TSCLiveSwiperChannel
-(void)setCards:(NSArray *)cards{
//    NSLog(@"%@",cards);
//    NSMutableArray *temp = [[NSMutableArray alloc]init];
//    for (NSDictionary *data in cards) {
//        TSCLive *card = [TSCLive mj_objectWithKeyValues:data];
//        [temp addObject:card];
//    }
    _cards = [TSCLive mj_objectArrayWithKeyValuesArray:cards];
}
-(void)setResource:(NSArray *)resource{
//    NSLog(@"%@",resource);
//    NSMutableArray *temp = [[NSMutableArray alloc]init];
//    for (NSDictionary *data in resource) {
//        TSCLiveSwiperChannelResource *r = [TSCLiveSwiperChannelResource mj_objectWithKeyValues:data];
//        [temp addObject:r];
//    }
    _resource = [TSCLiveSwiperChannelResource mj_objectArrayWithKeyValuesArray:resource];
}
@end
 
