//
//  TSCHotSpecialData.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/16.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCTicker.h"
@interface TSCHotSpecialData : NSObject
@property (nonatomic, assign) NSInteger pos;
@property (nonatomic, strong) NSString * redirectType;
@property (nonatomic, strong) NSArray<TSCTicker *> * ticker;
@property (nonatomic, strong) NSString * token;
@end
