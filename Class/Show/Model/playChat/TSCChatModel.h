//
//  TSCChatModel.h
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/3.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCChatModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSNumber *userLevel;
@property (nonatomic, assign) BOOL isMoreLine;
@property (nonatomic, strong) NSNumber *tableWidth;
@property (nonatomic, strong) NSString *firstContent;
@property (nonatomic, strong) NSString *secondContent;
@property (nonatomic, assign) CGSize secondContentSize;
@property (nonatomic, strong) NSNumber *cellHeight;
@property (nonatomic,strong) NSNumber *backgroundTrailling;

-(instancetype)initWithDictinary:(NSDictionary *)dict;
@end
