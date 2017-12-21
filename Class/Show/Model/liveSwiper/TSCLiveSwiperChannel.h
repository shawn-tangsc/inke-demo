//
//  TSCLiveSwiperChannel.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/16.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCLive.h"
#import "TSCLiveSwiperChannelResource.h"

@interface TSCLiveSwiperChannel : NSObject
@property (nonatomic, strong) NSArray<TSCLive *> * cards;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray<TSCLiveSwiperChannelResource *> * resource;
@property (nonatomic, strong) NSString * tabKey;
@end
