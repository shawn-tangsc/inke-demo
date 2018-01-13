//
//  TSCBulletView.m
//  Test-inke
//  自己造轮子之弹幕

//  要创建一个自带xib的view，首先先创建类，ra
//  Created by 唐嗣成 on 2018/1/9.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import "TSCBulletView.h"
#define Padding 15
#define Duration 4.0f

@interface TSCBulletView()
@property (nonatomic,strong) UILabel *content;
@property (nonatomic,retain) NSArray *colors;

@end
@implementation TSCBulletView

-(NSArray *)colors{
    if(!_colors){
        _colors = [NSArray arrayWithObjects:
            @[(__bridge id)[UIColor colorWithRed:57.0/255.0 green:50.0/255.0 blue:165.0/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:57.0/255.0 green:50.0/255.0 blue:165.0/255.0 alpha:0.5].CGColor],
            @[(__bridge id)[UIColor colorWithRed:219.0/255.0 green:223.0/255.0 blue:21.0/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:219.0/255.0 green:223.0/255.0 blue:21.0/255.0 alpha:0.5].CGColor],
            @[(__bridge id)[UIColor colorWithRed:57.0/255.0 green:201.0/255.0 blue:241.0/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:57.0/255.0 green:201.0/255.0 blue:241.0/255.0 alpha:0.5].CGColor], nil];
    }
    return _colors;
}
-(UILabel *)content{
    if(!_content){
        _content = [[UILabel alloc]initWithFrame:CGRectZero];
        _content.font = [UIFont systemFontOfSize:13];
        _content.textColor = [UIColor whiteColor];
        _content.textAlignment = NSTextAlignmentCenter;
    }
    return _content;
}

-(instancetype) initWithContent:(NSString *)content{
    if(self = [super init]){
//        self.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.layer.borderWidth = 0.5;
        //计算弹幕的实际宽度
        CGFloat width = [content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
        
        self.bounds = CGRectMake(0, 0, width+2*Padding, 30);
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;

        //这里我们做一个透明度渐变的画板
        CAGradientLayer *gl = [CAGradientLayer layer];
        /*
            __bridge 是ARC下对象和CF对象之间的桥接(bridge)https://www.jianshu.com/p/b17ec48857aa
         
            (__bridge <type>)<expression>) 仅仅将值的地址进行转换，并没有转移对象的所有权，如果被桥接的对象释放，则桥接后的值也无法使用。在ARC下使用__bridge，因为所有权仍然属于OC，因此归ARC管制，不必手动释放。
         
            这里有一个比较详细的用法http://blog.csdn.net/zhoushuangjian511/article/details/51200301
         
            不过这个渐变比较有局限性，还有几种做法可取，https://www.jianshu.com/p/3e0e25fd9b85
         */
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:57.0/255.0 green:50.0/255.0 blue:165.0/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:57.0/255.0 green:50.0/255.0 blue:165.0/255.0 alpha:0.5].CGColor];
//        NSInteger * index =arc4random()%3;
//        NSLog(@"拿随机数%d",index);
        gl.colors = [self.colors objectAtIndex:arc4random()%3] ;
        gl.locations = @[@0];
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint =CGPointMake(1.0, 0);
        gl.frame = self.bounds;
        [self.layer addSublayer:gl];
        self.content.text = content;
        [self addSubview:self.content];
        self.content.frame = CGRectMake(Padding, 0, width, 30);
    }
    return self;
}

/**
 根据弹幕的长度执行弹幕的效果
 根据v= s/t ，时间相同的情况下，距离越长，速度越快
 */
-(void) startAnimation{

    CGFloat wholeWidth = SCREEN_WIDTH + CGRectGetWidth(self.bounds);
    
    if(self.moveStatusBlock){
        self.moveStatusBlock(Start);
    }
    CGFloat speed = wholeWidth/Duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    //有个缺点，不能让需求停止
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if(self.moveStatusBlock){
//            self.moveStatusBlock(Enter);
//        }
//    });
    //这里就可以让弹幕实现停止效果，在经过afterDelay时间后执行某个方法performSelector
    //http://blog.csdn.net/hong1595/article/details/34102207 相当于javascript的setinterval
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration+0.5];
    
    //如果block内部需要对外部的变量进行访问，则需要给这些变量加上__block关键字修饰，这样就可以在block中修改这些变量。
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:Duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -=wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.moveStatusBlock){
            self.moveStatusBlock(End);
        }
    }];
}

-(void)enterScreen {
    //对应performSelector,取消前面所注册过performSelector方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if(self.moveStatusBlock){
        self.moveStatusBlock(Enter);
    }
}

-(void) stopAnimation{
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

@end
