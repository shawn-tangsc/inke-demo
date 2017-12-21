//
//  TSCLiveHandler.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/19.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCLiveHandler.h"
#import "TSCHttpTool.h"
#import "TSCCards.h"
#import "TSCFlow.h"
#import "TSCGifts.h"
@implementation TSCLiveHandler

+ (void) executeGetHotLiveTaskWithSuccess:(SuccessBlock) success failed:(FailedBlock) failed{
    [TSCHttpTool getWithPath:API_HotLive param:nil success:^(id json) {
        
        if([json[@"dm_error"] integerValue]){
            failed(json);
        }else{
            //如果返回信息正确
            //数据解析
//            NSArray *lives = [TSCCards mj_objectArrayWithKeyValuesArray:json[@"cards"]];
            success(json);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

+ (void) executeGetNearFlowTaskWithData:(NSDictionary *)data Success:(SuccessBlock) success failed:(FailedBlock) failed{
    [TSCHttpTool getWithPath:API_Near param:data success:^(id json) {
        if([json[@"dm_error"] integerValue]){
            failed(json);
        }else{
            NSArray *flows = [TSCFlow mj_objectArrayWithKeyValuesArray:json[@"flow"]];
            success(flows);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

+(void) getLiveUsersWithData:(NSDictionary *)data success:(SuccessBlock) success failed:(FailedBlock) failed{
    [TSCHttpTool getWithPath:API_Live_Users param:data success:^(id json) {
        if([json[@"dm_error"] integerValue]){
            failed(json);
        }else {           
            success(json);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

+ (void) getLiveGiftsWithData:(NSDictionary *)data success:(SuccessBlock) success failed:(FailedBlock) failed{
    [TSCHttpTool getWithPath:API_Live_Gift param:data success:^(id json) {
        if([json[@"dm_error"] integerValue]){
            failed(json);
        }else {
            NSArray *flows = [TSCGifts mj_objectArrayWithKeyValuesArray:json[@"gifts"]];
            success(flows);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

@end
