//
//  TSCLiveHandler.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/19.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCBaseHandler.h"

@interface TSCLiveHandler : TSCBaseHandler

/**
 获取热门直播信息

 @param success 成功
 @param failed 失败
 */
+ (void) executeGetHotLiveTaskWithSuccess:(SuccessBlock) success failed:(FailedBlock) failed;

+ (void) executeGetNearFlowTaskWithData:(NSDictionary *)data Success:(SuccessBlock) success failed:(FailedBlock) failed;

+ (void) getLiveUsersWithData:(NSDictionary *)data success:(SuccessBlock) success failed:(FailedBlock) failed;

+ (void) getLiveGiftsWithData:(NSDictionary *)data success:(SuccessBlock) success failed:(FailedBlock) failed;
@end
