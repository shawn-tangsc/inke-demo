//
//  TSCBaseHandler.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/19.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
//处理完成事件
typedef void(^CompleteBlock)(void);


/**
 处理事件成功
 
 @param obj 返回数据
 */
typedef void(^SuccessBlock)(id obj);


/**
 处理事件失败
 
 @param obj 错误信息
 */
typedef void(^FailedBlock)(id obj);
@interface TSCBaseHandler : NSObject

@end
