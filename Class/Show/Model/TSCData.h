//
//  TSCData.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/24.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCLive.h"

@interface TSCData : NSObject

@property (nonatomic, strong) TSCLive * liveInfo;
@property (nonatomic, assign) NSInteger pos;
@property (nonatomic, strong) NSString * redirectType;

@end
