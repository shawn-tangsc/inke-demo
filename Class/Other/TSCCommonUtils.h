//
//  TSCCommonUtils.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/7.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCCommonUtils : NSObject

+ (UIViewController *_Nonnull)superViewController:(UIViewController *_Nullable)vc;

+ (NSString *_Nullable) getCurrentNetworkStatus;

+ (UIViewController *_Nullable)getSuperViewController:(NSString *_Nullable)controllerName target:(nullable id)target;

@end
