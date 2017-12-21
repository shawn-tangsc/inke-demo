//
//  UIImageView+SDWebImage.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import "uiimageView+WebCache.h"


@implementation UIImageView (SDWebImage)

-(void) downloadImage:(NSString *)url placeholder:(NSString *) imageName{
//    NSLog(@"%L",SDWebImageRetryFailed|SDWebImageLowPriority);
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority];
}


-(void)downloadImage:(NSString *)url
         placeholder:(NSString *)imageName
             success:(DownloadImageSuccessBLock)success
              failed:(DownloadImageFailedBlock)failed
            progress:(DownloadImageProgressBlock)progress{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        progress(receivedSize * 1.0 / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            failed(error);
        }else {
            self.image = image;
            success(image);
        }
    }];
}



@end
