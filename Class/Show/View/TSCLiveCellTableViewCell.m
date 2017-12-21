//
//  TSCLiveCellTableViewCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/25.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCLiveCellTableViewCell.h"
#import "TSCTabBarViewController.h"

@interface TSCLiveCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@end


@implementation TSCLiveCellTableViewCell

//?
-(void)setLive:(TSCLive *)live{
    
    _live = live;
     NSString *imagePath =[live.creator.portrait hasPrefix:@"http://"]?live.creator.portrait: [NSString stringWithFormat:@"%@%@",RESOURCE_HOST,live.creator.portrait];
    [self.headView downloadImage:imagePath placeholder:@"default_room"];
    
    [self.bigImageView downloadImage:imagePath placeholder:@"default_room"];
    self.nameLabel.text = live.creator.nick;
    self.onLineLabel.text = [@(live.onlineUsers) stringValue];;
    self.locationLabel.text = live.city;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //可以在xib中的 headView 的image 的show the identity inspector 中的user Defined runtime attributes 里面填写
//    self.headView.layer.cornerRadius = CGRectGetWidth(self.headView.frame) / 2;
//    self.headView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
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
