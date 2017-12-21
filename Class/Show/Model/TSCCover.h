//
//  TSCCover.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/24.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCCoverElements.h"
@interface TSCCover : NSObject
@property (nonatomic, strong) NSArray<TSCCoverElements *> * elements;
@property (nonatomic, assign) NSInteger style;

@end
