//
//  TSCLive.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/23.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCCreator.h"
#import "TSCExtra.h"
#import "TSCActInfo.h"

@interface TSCLive : NSObject
@property (nonatomic, strong) TSCActInfo * actInfo;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) TSCCreator * creator;
@property (nonatomic, strong) TSCExtra * extra;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger landscape;
@property (nonatomic, strong) NSArray * like;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, strong) NSString * liveType; 
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onlineUsers;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSString * distance;
@property (nonatomic, getter=isShow) BOOL show;
@end
