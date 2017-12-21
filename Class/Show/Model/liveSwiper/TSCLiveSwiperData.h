//
//  TSCLiveSwiperData.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/16.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCLiveSwiperChannel.h"
#import "TSCLiveSwiperExtra.h"
@interface TSCLiveSwiperData : NSObject
@property (nonatomic, strong) TSCLiveSwiperChannel * channel;
@property (nonatomic, strong) TSCLiveSwiperExtra * extra;
@property (nonatomic, assign) NSInteger pos;
@property (nonatomic, strong) NSString * redirectType;
@property (nonatomic, strong) NSString * token;
@end
