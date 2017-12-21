//
//  TSCHotLiveCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/17.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHotLiveCell.h"
#import "TSCTabBarViewController.h"
@interface TSCHotLiveCell()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineUsersLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end

@implementation TSCHotLiveCell
-(void)setLive:(TSCLive *)live{
    _live = live;
    NSString *imagePath =[live.creator.portrait hasPrefix:@"http://"]?live.creator.portrait: [NSString stringWithFormat:@"%@%@",RESOURCE_HOST,live.creator.portrait];
    [self.userImage downloadImage:imagePath placeholder:@"default_room"];
    self.userNickLabel.text = live.creator.nick;
    self.onlineUsersLabel.text =[NSString stringWithFormat:@"%ld正在看",(long)live.onlineUsers] ;//[@(live.onlineUsers) stringValue];
    self.locationLabel.text = live.city;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark 检测用户的点击事件是否在tabbar的按钮里，如果是则出发按钮效果
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
