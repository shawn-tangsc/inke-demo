//
//  TSCTabBar.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/22.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCTabBar.h"

@interface TSCTabBar ()

@property (nonatomic,strong) UIImageView * tabbgView;
@property (nonatomic,strong) NSArray * datalist;
@property (nonatomic,strong) UIButton * lastItem;
@property (nonatomic,strong) UIButton * camearButton;

@end

@implementation TSCTabBar
- (UIButton *) camearButton{
    if(!_camearButton){
        _camearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_camearButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
//        [_camearButton sizeToFit];
        _camearButton.tag =  TSCItemTypeLaunch;
        [_camearButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _camearButton;
}


-(NSArray *) datalist{
    if(!_datalist){
        _datalist = @[@"tab_live",@"tab_me"];
    }
    return _datalist;
}

-(UIImageView *) tabbgView{
    if(!_tabbgView){
        _tabbgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabbgView;
}
-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //装载背景
        [self addSubview:self.tabbgView];
        //装载item
        for (NSInteger i = 0; i<self.datalist.count; i++) {
            UIButton * item = [UIButton buttonWithType:UIButtonTypeCustom];
            item.adjustsImageWhenHighlighted = NO;//点击图片取消高亮状态
            [item setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = TSCItemTypeLive+i;
            if(i == 0 ){
                item.selected = YES;
                self.lastItem = item;
            }
            
            [self addSubview:item];
        }
        //添加直播按钮
        [self addSubview:self.camearButton];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    self.tabbgView.frame = self.bounds;
    CGFloat width = self.bounds.size.width/ self.datalist.count;
    for (NSInteger i =0; i<[self subviews].count; i++) {
        UIView * btn = [self subviews][i];
        
        if([btn isKindOfClass:[UIButton class]]){
            btn.frame = CGRectMake((btn.tag - TSCItemTypeLive)*width, 0, width, self.frame.size.height);
        }
    }
    [self.camearButton sizeToFit];
    self.camearButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.5 -20);
    
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return YES;
}
//当按钮超过父视图范围，点击是没有反应的，因为消息的传递是从最下层的父视图开始调用hittest方法的
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *result = [super hitTest:point withEvent:event];
    CGPoint buttonPoint = [self.camearButton convertPoint:point fromView:self];
    if ([self.camearButton pointInside:buttonPoint withEvent:event]) {
        return self.camearButton;
    }
    return result;
}

-(void)clickItem:(UIButton * )button{
    if([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]){
        [self.delegate tabbar:self clickButton:button.tag];
    }
    //    !self.block?:self.block(self,button.tag);
    if(self.block){
        self.block(self, button.tag);
        
    }
    if(button.tag == TSCItemTypeLaunch){
        return;
    }
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    //设置动画
    [UIView animateWithDuration:0.2 animations:^{
        //将button扩大到1.2倍
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        //恢复原始状态
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
    
    
    
}
@end
