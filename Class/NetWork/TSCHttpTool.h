//
//  TSCHttpTool.h
//  Test-inke
//  调用接口的类
//  Created by 唐嗣成 on 2017/11/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^HttpSuccessBlock)(id json);
typedef void(^HttpFailureBlock)(NSError * error);
typedef void(^HttpDownloadPregressBlock)(CGFloat progress);
typedef void(^HttpUploadProgressBlock)(CGFloat progress);

@interface TSCHttpTool : NSObject


/**
 get请求

 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 成功回调
 @param failure 失败回调
 */
+(void)getWithPath:(NSString *)path
             param:(NSDictionary *)params
           success:(HttpSuccessBlock)success
           failure:(HttpFailureBlock)failure;


/**
 post请求

 @param path url地址
 @param params url参数 NSDictionary类型
 @param success 成功回调
 @param failure 失败回调
 */
+(void)postWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

/**
 下载文件

 @param path url路径
 @param success 下载成功
 @param failure 爱在失败
 @param progress 下载进度
 */
+(void)downloadWithPath:(NSString *)path
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure
               progress:(HttpDownloadPregressBlock)progress;

/**
 上传图片

 @param path url地址
 @param params UIImage对象
 @param imagekey Imagekey
 @param image 上传参数
 @param success 上传成功
 @param failure 上传失败
 @param progress 上传进度
 */
+(void)uploadImageWithPath:(NSString *)path
                    params:(NSDictionary *)params
                 thumbName:(NSString *)imagekey
                     image:(UIImage *)image
                   success:(HttpSuccessBlock)success
                   failure:(HttpFailureBlock)failure
                  progress:(HttpUploadProgressBlock)progress;

@end
