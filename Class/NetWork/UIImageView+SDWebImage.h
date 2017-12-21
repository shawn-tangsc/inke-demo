//
//  UIImageView+SDWebImage.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DownloadImageSuccessBLock)(UIImage *image);
typedef void(^DownloadImageFailedBlock)(NSError *error);
typedef void(^DownloadImageProgressBlock)(CGFloat progress);

@interface UIImageView (SDWebImage)


/**
 异步加载图片

 @param url 图片地址
 @param imageName 占位图片名
 */
-(void) downloadImage:(NSString *)url placeholder:(NSString *) imageName;


/**
 异步加载图片，可以监听进度，成功或失败

 @param url 图片地址
 @param imageName 占位图片名
 @param success 下载成功
 @param failed 下载失败
 @param progress 下载进度
 */
-(void)downloadImage:(NSString *)url
         placeholder:(NSString *)imageName
             success:(DownloadImageSuccessBLock)success
              failed:(DownloadImageFailedBlock)failed
            progress:(DownloadImageProgressBlock)progress;




@end
