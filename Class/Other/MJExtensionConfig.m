//
//  MJExtensionConfig.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/23.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "TSCCreator.h"
#import "TSCLive.h"
#import "TSCLabel.h"
#import "TSCData.h"
#import "TSCExtra.h"
#import "TSCFlow.h"
#import "TSCGifts.h"
#import "TSCResource.h"
#import "TSCLevelInfo.h"
#import "TSCResourceExtra.h"
#import "TSCHotSpecialData.h"
#import "TSCAdvertisingRecord.h"
@implementation MJExtensionConfig


+ (void) load{
    /**
     将不一样的jsonname替换成modelname
     */
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID": @"id"
                 };
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        if ([propertyName isEqualToString:@"ID"]) return @"id";
        return [propertyName mj_underlineFromCamel];
    }];
    
    [TSCCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc": @"description"
                 };
    }];
//    [TSCLive mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"ID":@"id"
//                 };
//    }];
    //驼峰转换
    //一开始把id转称ID后，转换后来拿不到值，百度很久没有找到方案，在gitHub上翻看issue很久，终于在closed issue里找到了原因和解决方法。
    //mj_replacedKeyFromPropertyName121方法优先级比 mj_underlineFromCamel方法高，1个key在执行mj_replacedKeyFromPropertyName121方法的时候已经经过mj_underlineFromCamel方法返回具体值，不会再执行mj_replacedKeyFromPropertyName方法。
    //可以将mj_replacedKeyFromPropertyName的内容写到mj_replacedKeyFromPropertyName121，合二为一
//    [TSCCreator mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCLive mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCLabel mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCData mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCFlow mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCGifts mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCResource mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCLevelInfo mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//         if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCResourceExtra mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//         if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCHotSpecialData mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//         if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
//    [TSCAdvertisingRecord mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//         if ([propertyName isEqualToString:@"ID"]) return @"id";
//        return [propertyName mj_underlineFromCamel];
//    }];
}

@end
