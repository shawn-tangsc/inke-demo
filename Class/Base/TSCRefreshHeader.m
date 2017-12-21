//
//  TSCRefreshHeader.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/6.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCRefreshHeader.h"

@implementation TSCRefreshHeader

#pragma mark - 重写方法
#pragma mark 基本设置
-(void)prepare{
    [super prepare];
    NSMutableArray *refreshImages = [NSMutableArray array];
    //NSUInteger 是无符号型的整形
    for(NSUInteger i=11 ; i<=29 ; i++){
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_fly_00%zd",i]];
        [refreshImages addObject:[image imageByResizeToSize:CGSizeMake(50, 50)]];
        
        
    }
    //设置普通状态的动画图片
    [self setImages:refreshImages forState:MJRefreshStateIdle];
    //设置即将刷新状态的动画图片 （一松开就会刷新的状态）
    [self setImages:refreshImages forState:MJRefreshStatePulling];
    //设置正在刷新状态的动画图片
    [self setImages:refreshImages duration:.8  forState:MJRefreshStateRefreshing];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end
