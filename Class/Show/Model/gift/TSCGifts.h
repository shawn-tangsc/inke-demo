//
//  TSCGifts.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCGiftExtra.h"
#import "TSCLevelInfo.h"
#import "TSCResource.h"
@interface TSCGifts : NSObject
@property (nonatomic, strong) NSString * chatIcon;
@property (nonatomic, strong) NSArray * cl;
@property (nonatomic, assign) NSInteger dyna;
@property (nonatomic, strong) NSArray * dynamic;
@property (nonatomic, assign) NSInteger exp;
@property (nonatomic, strong) TSCGiftExtra * extra;
@property (nonatomic, strong) NSArray * giftIconId;
@property (nonatomic, assign) NSInteger gold;
@property (nonatomic, assign) NSInteger goldType;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, strong) NSString * image3;
@property (nonatomic, assign) NSInteger isMulti;
@property (nonatomic, strong) TSCLevelInfo * levelInfo;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger point;
@property (nonatomic, assign) CGFloat recvRate;
@property (nonatomic, assign) NSInteger replaceId;
@property (nonatomic, strong) TSCResource * resource;
@property (nonatomic, assign) NSInteger secondCurrency;
@property (nonatomic, assign) NSInteger starLight;
@property (nonatomic, assign) NSInteger type;
//????
@property (nonatomic, getter=isSelected) BOOL selected;
@end
