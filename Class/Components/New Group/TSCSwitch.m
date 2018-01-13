//
//  TSCSwitch.m
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/13.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import "TSCSwitch.h"

@interface TSCSwitch ()

@property (nonatomic,strong) UIView *onView;

@property (nonatomic,strong) UIView  *offView;

@property (nonatomic,strong) UIView *thumbView;

@property (nonatomic, strong) UILabel *lable;

@property (nonatomic, assign) BOOL isOn;

@end


@implementation TSCSwitch
{
    //在interface里面定义的@property 其实会自己在这里生成一个带下划线的变量。这个变量不回触发set和get方法
//    CGPoint _swithOrgin;
    void(^_startBlock)(BOOL isOn);
    void(^_endBlock)(BOOL isOn);
}

#pragma mark -- 一些常量

//static float const swichHeight = 25;
//static float const swichWidth = 36;
static float const thumbViewMargin = 2;
static float const swichAnimatedDuration = 0.6;


#pragma mark -- 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//        _swithOrgin = frame.origin;
//        self.frame = frame;
        self.backgroundColor = [UIColor redColor];
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
    }
    
    return self;
}

- (void)initialize{
    
//    self.frame = CGRectMake(_swithOrgin.x, _swithOrgin.y, swichWidth, swichHeight);
    
    // 切圆角
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    self.layer.masksToBounds = YES;
    
    // 添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swith)];
    [self addGestureRecognizer:tapGesture];
    
    
    /*
     这种self.xxx=({xxxx})这个是oc的语法糖，可以参考https://www.jianshu.com/p/7e7089b5adbd
     */
    // 添加视图
    self.onView = ({
        UIView *onView = [[UIView alloc] init];
        onView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        onView.backgroundColor = [UIColor yellowColor];
        [self addSubview:onView];
        onView;
    });
    
    self.offView = ({
        UIView *offView = [[UIView alloc] init];
        offView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        offView.backgroundColor = [UIColor blackColor];
        [self addSubview:offView];
        offView;
    });
    
    self.thumbView = ({
        UIView *thumbView = [[UIView alloc] init];
        thumbView.frame = CGRectMake( thumbViewMargin, thumbViewMargin, self.frame.size.height - thumbViewMargin*2, self.frame.size.height - thumbViewMargin*2);
        thumbView.backgroundColor = [UIColor blueColor];
        thumbView.layer.cornerRadius = (self.frame.size.height - thumbViewMargin*2) *0.5;
        [self addSubview:thumbView];
        thumbView;
    });
    
    self.lable = ({
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.thumbView.width,self.thumbView.height)];
        lable.frame = self.thumbView.bounds;
        lable.text = @"弹";
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:9];
        [self.thumbView addSubview:lable];
//        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.thumbView.mas_centerX);
//            make.centerY.equalTo(self.thumbView.mas_centerY);
//        }];
        lable;
    });
}

#pragma mark -- 点击事件及动画实现

- (void)swith{
    
    if (_startBlock) {
        _startBlock(self.isOn);
    }
    
    // 实现动画 分两步.
    [UIView animateWithDuration:swichAnimatedDuration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGRect thumbViewOrigin = self.thumbView.frame;
        if (self.isOn) {
            thumbViewOrigin.origin.x = thumbViewMargin;
             self.lable.textColor = self.tintColor;
        }
        else {
            thumbViewOrigin.origin.x = self.frame.size.width - thumbViewMargin - self.thumbView.frame.size.width;
            self.lable.textColor = self.onTintColor;
        }
        self.thumbView.frame = thumbViewOrigin;
        
    } completion:nil];
    
    UIView *animatedView;
    if (self.isOn) {
        animatedView = self.onView;
    }
    else {
        animatedView = self.offView;
    }
    UIColor * animatedcolor = animatedView.backgroundColor;
    
    [UIView animateWithDuration:swichAnimatedDuration animations:^{
        
        animatedView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
       
        [self insertSubview:animatedView atIndex:0];
  
        animatedView.backgroundColor = animatedcolor;
       
//        self.lable.textColor =animatedView.backgroundColor;

        self.isOn = !self.isOn;
        
        if (_endBlock) {
            _endBlock(self.isOn);
        }
    }];
}

#pragma mark -- 开关回调

- (void)switchDidEndSwitch:(void (^)(BOOL))endBlock{
    
    _endBlock = endBlock;
}

- (void)switchWillStartSwicth:(void (^)(BOOL))startBlock{
    
    _startBlock = startBlock;
}

#pragma mark -- 属性设置

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    self.offView.backgroundColor = tintColor;
    self.lable.textColor = tintColor;
}

- (void)setOnTintColor:(UIColor *)onTintColor{
    _onTintColor = onTintColor;
    self.onView.backgroundColor = onTintColor;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor{
    
    self.thumbView.backgroundColor = thumbTintColor;
}
-(void)setTumbText:(NSString *)tumbText{
    self.lable.text = tumbText;
}
@end
