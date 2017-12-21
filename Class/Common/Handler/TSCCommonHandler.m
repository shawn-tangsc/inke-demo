//
//  TSCCommonHandler.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCCommonHandler.h"
#import "TSCHttpTool.h"
#import "TSCAdvertisingData.h"
@implementation TSCCommonHandler

+ (void) getAdvertisingWithSuccess:(SuccessBlock) success failed:(FailedBlock) failed{
    NSString *url = [NSString stringWithFormat:@"%@%@",WEBAPI_HOST,APP_Flash_Screen];
    [TSCHttpTool getWithPath:url param:nil success:^(id json) {
        if([json[@"dm_error"] integerValue]){
            failed(json);
        }else {
            TSCAdvertisingData *data = [TSCAdvertisingData mj_objectWithKeyValues:json[@"data"]];
            success(data);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

@end
