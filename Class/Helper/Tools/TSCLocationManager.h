//
//  TSCLocationManager.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/2.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^locationBlock)(NSString * lat, NSString * lon);

@interface TSCLocationManager : NSObject
+ (instancetype) sharedManager;

-(void) getGPS:(locationBlock)block;

@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * lon;
@end
