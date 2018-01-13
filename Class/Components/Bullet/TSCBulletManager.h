//
//  TSCBulletManager.h
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/9.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCBulletView.h"
#import "TSCChatModel.h"
@interface TSCBulletManager : NSObject
//弹幕的数据来源
@property (nonatomic,strong) NSMutableArray *datasource;
/*
    为什么通常block是用copy来修饰的https://www.jianshu.com/p/acb7c470de63
 
 */
@property (nonatomic,copy)void (^generateViewblock)(TSCBulletView *view);
//弹幕开始执行
-(void) start;
//弹幕停止执行
-(void) end;

-(void) refresh:(NSString *)content;
@end
