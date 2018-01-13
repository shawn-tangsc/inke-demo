//
//  TSCBulletManager.m
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/9.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import "TSCBulletManager.h"

@interface TSCBulletManager()

//弹幕使用过程中的数组变量
@property (nonatomic, strong) NSMutableArray *bulletsContent;
//存储弹幕view的数组变量
@property (nonatomic, strong) NSMutableArray<TSCBulletView *> *bulletViews;
@property BOOL bStopAnimation;
@end
@implementation TSCBulletManager
#pragma mark init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bStopAnimation = YES;
    }
    return self;
}

#pragma mark overwrite
//弹幕开始执行
-(void) start{
    if(!self.bStopAnimation){
        return;
    }
    self.bStopAnimation = NO;
    [self.bulletsContent removeAllObjects];
    [self.bulletsContent addObjectsFromArray:self.datasource];
    [self initBulletContent];
}

//弹幕停止执行
-(void) end{
    if(self.bStopAnimation){
        return;
    }
    [self.bulletViews enumerateObjectsUsingBlock:^(TSCBulletView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TSCBulletView *view = obj;
        [view stopAnimation];
        view=nil;
    }];
    [self.bulletViews removeAllObjects];
    self.bStopAnimation = YES;
}
#pragma mark private-function

/**
 初始化弹幕，随机分配弹幕轨迹
 */
-(void)initBulletContent{
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for (int i = 0 ; i <3; i++) {
        NSLog(@"进来了");
        if(self.bulletsContent.count >0){
            //通过随机数获取到弹幕的轨迹
            NSInteger index = arc4random()%trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>%d",trajectory);
            //
            [trajectorys removeObjectAtIndex:index];
            
            //从弹幕数组中逐一取出弹幕数据
            NSString *content = [self.bulletsContent firstObject];
            [self.bulletsContent removeObjectAtIndex:0];
             //创建弹幕
            [self createBulletView:content trajectory:trajectory];
        }
    }
}

-(void) createBulletView:(NSString *)content trajectory:(int)trajectory{
    if(self.bStopAnimation){
        return;
    }
    TSCBulletView *view = [[TSCBulletView alloc]initWithContent:content];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    __weak typeof (view) weakView = view;
    __weak typeof (self) myself = self;
//    __block NSString *nextContent = nil;
    view.moveStatusBlock = ^(MoveStatus status){
        if(myself.bStopAnimation){
            return;
        }
        switch (status) {
            case Start:
                //弹幕开始进入屏幕，将view加入到弹幕管理中bulletViews
                [myself.bulletViews addObject:weakView];
                break;
            case Enter:{
                /*
                这里有个问题，使用switch的时候，case里面不能直接去定义对象，一定义对象就会报错。
                了解了一下c和c++，任何一个对象，都必须定义在一个花括号{}里面，这样该对象才能将作用域绑定到花括号里面，所以如果switch内要定义对象，就必须在一个花括号内。
                 */
                
                //弹幕完全进入屏幕，要判断是否还有其他内容，如果有则在该弹幕轨迹中创建一个弹幕
                NSString *nextContent =[myself nextContent];
                if(nextContent){
                    [myself createBulletView:nextContent trajectory:trajectory];
                }
                break;
            }
            case End:
                //弹幕完全飞出屏幕后从bulletViews屏幕中删除，释放资源。
                if([myself.bulletViews containsObject:weakView]){
                    [weakView stopAnimation];
                    [myself.bulletViews removeObject:weakView];
                }
                if(myself.bulletViews.count == 0){
                    self.bStopAnimation = YES;
                    //说明屏幕上已经没有弹幕了，开始循环滚动
                    [myself start];
                }
                break;
            default:
                break;
        }
        //移出屏幕后销毁弹幕并释放资源
//        [weakView stopAnimation];
//        [myself.bulletViews removeObject:weakView];
    };
    if(self.generateViewblock){
        self.generateViewblock(view);
    }
}
-(NSString *)nextContent{
    if(self.bulletsContent.count == 0){
        return nil;
    }
    NSString *content = [self.bulletsContent firstObject];
    if(content){
        [self.bulletsContent removeObjectAtIndex:0];
    }
    return content;
}

-(void) refresh:(NSString *)content{
    [self.datasource addObject:content];
    [self start];
}
#pragma mark lazy

-(NSMutableArray *)datasource{
    if(!_datasource){
        _datasource = [NSMutableArray arrayWithArray:@[]];
    }
    return _datasource;
}

-(NSMutableArray *)bulletsContent{
    if(!_bulletsContent){
        _bulletsContent = [NSMutableArray arrayWithArray:@[]];
    }
    return _bulletsContent;
}
-(NSMutableArray *)bulletViews{
    if(!_bulletViews){
        _bulletViews = [NSMutableArray arrayWithArray:@[]];
    }
    return _bulletViews;
}
@end
