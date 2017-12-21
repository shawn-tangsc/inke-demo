//
//  TSCAdvertisingRecord.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCAdvertisingRecord : NSObject
@property (nonatomic, assign) NSInteger dEnd;
@property (nonatomic, assign) NSInteger dStart;
@property (nonatomic, strong) NSString * delay;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, assign) BOOL skip;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * video;
@end
