//
//  TSCCommonHandler.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCBaseHandler.h"

@interface TSCCommonHandler : TSCBaseHandler

+ (void) getAdvertisingWithSuccess:(SuccessBlock) success failed:(FailedBlock) failed;

@end
