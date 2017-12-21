//
//  TSCResource.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCResourceExtra.h"
@interface TSCResource : NSObject
@property (nonatomic, assign) NSInteger aid;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) TSCResourceExtra * extra;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * pic3;
@end
