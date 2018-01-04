//
//  TSCNearLiveCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/2.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCNearLiveCell.h"
#import "TSCTabBarViewController.h"

@interface TSCNearLiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UIView *levelBackground;

@end
@implementation TSCNearLiveCell

-(void)setInfo:(TSCLive *)info{
    _info = info;
    NSString *imagePath =[info.creator.portrait hasPrefix:@"http://"]?info.creator.portrait: [NSString stringWithFormat:@"%@%@",RESOURCE_HOST,info.creator.portrait];
    [self.headView downloadImage:imagePath placeholder:@"default_room"];
    self.distance.text = info.distance;
    self.level.text = [NSString stringWithFormat:@"%ld",info.creator.level];
    //根据用户等级，判断等级部分的背景颜色
    if(info.creator.level < 17){
        self.levelBackground.backgroundColor = [UIColor colorWithRed:147.0/225.0 green:202.0/225.0 blue:20.0/225.0 alpha:1];
    }else if (info.creator.level<30 && 17<=info.creator.level){
        self.levelBackground.backgroundColor = [UIColor colorWithRed:246.0/225.0 green:141.0/225.0 blue:73.0/225.0 alpha:1];

    }else if (info.creator.level<70 && 30<=info.creator.level){
        self.levelBackground.backgroundColor = [UIColor colorWithRed:249.0/225.0 green:101.0/225.0 blue:164.0/225.0 alpha:1];

    }else if (info.creator.level<150 && 70<=info.creator.level){
        self.levelBackground.backgroundColor = [UIColor colorWithRed:60.0/225.0 green:214.0/225.0 blue:215.0/225.0 alpha:1];

    }else {
        self.levelBackground.backgroundColor = [UIColor colorWithRed:124.0/225.0 green:150.0/225.0 blue:245.0/225.0 alpha:1];
    }
}

-(void)showAnimation{
    if(self.info.isShow){
        return;
    }
    //详见 ： http://blog.sina.com.cn/s/blog_8f5097be0101b91z.html
    //需要一定线性代数的知识
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    self.info.show = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 重写点击事件，如果点击区域在直播按钮上，则返回直播按钮的事件
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    TSCTabBarViewController * tabbarVC = nil;
    
    if ([vc isKindOfClass:[TSCTabBarViewController class]])
    {
        tabbarVC = (TSCTabBarViewController *)vc;
    }
    
    TSCTabBar* tabbar = tabbarVC.tscTabbar;
    UIButton* btn = tabbar.camearButton;
    UIView *result = [super hitTest:point withEvent:event];
    CGPoint buttonPoint = [btn convertPoint:point fromView:self];
    if ([btn pointInside:buttonPoint withEvent:event]) {
        return btn;
    }
    return result;
}
@end
