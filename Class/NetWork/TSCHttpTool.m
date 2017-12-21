//
//  TSCHttpTool.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHttpTool.h"
#import "AFNetworking.h"

static NSString * kBaseUrl = SERVER_HOST;

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype) sharedClient;

@end

@implementation AFHttpClient

+ (instancetype) sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        //设置参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",@"image/gif",nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 15;
        //安全策略 http和https的区别
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
    });
    
    return client;
    
}

@end


@implementation TSCHttpTool


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
           failure:(HttpFailureBlock)failure{
    //获取完整的url路径
    NSString * url =[path hasPrefix:@"http://"]?path:[kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


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
            failure:(HttpFailureBlock)failure{
    NSString * url =[path hasPrefix:@"http://"]?[kBaseUrl stringByAppendingPathComponent:path]:path;//会自动路径拼接，字符串前面自动加上／
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 下载文件
 
 @param path url路径
 @param success 下载成功
 @param failure 下载失败
 @param progress 下载进度
 */
+(void)downloadWithPath:(NSString *)path
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure
               progress:(HttpDownloadPregressBlock)progress{
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    //下载
    NSURL *URL  = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask * downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
         //获取沙盒cache路径临时文件夹
        NSURL * documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            failure(error);
        }else{
            success(filePath.path);
        };
    }];
    
    [downloadTask resume];
}

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
                  progress:(HttpUploadProgressBlock)progress{
    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:path];
    NSData * data = UIImagePNGRepresentation(image);
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:imagekey fileName:@"01.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
