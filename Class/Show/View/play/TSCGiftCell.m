//
//  TSCGiftCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/7.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCGiftCell.h"
@interface TSCGiftCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UIImageView *giftImage;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UIImageView *countType;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation TSCGiftCell

-(void)setGift:(TSCGifts *)gift{
    _gift = gift;
    [self.giftImage downloadImage:gift.image placeholder:@"" success:^(UIImage *image) {
        self.giftName.text = gift.name;
        self.typeImage.hidden = YES;
        if(gift.type == 1){
            self.typeImage.hidden = NO;
        }
        if(gift.goldType == 1){
            self.countLable.text = [NSString stringWithFormat:@"%ld",(long)gift.gold];
            self.countType.image = [UIImage imageNamed:@"first_charge_reward_diamond"];
        }else if (gift.goldType == 2){
            self.countLable.text = [NSString stringWithFormat:@"%ld",(long)gift.secondCurrency];
            self.countType.image = [UIImage imageNamed:@"first_charge_reward_star"];
        }
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(CGFloat progress) {
        
    }];
   
}

-(void) showAnimation {
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    // 开始时间 DISPATCH_TIME_NOW ，提交时间 1 * NSEC_PER_SEC（一秒后）
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{//设置响应dispatch源事件的block，在dispatch源指定的队列上运行
        self.giftImage.layer.transform = CATransform3DMakeScale(1, 1, 1);
        [UIView animateWithDuration:1 animations:^{
            self.giftImage.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
        }];
        [UIView animateWithDuration:1 animations:^{
            self.giftImage.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1);
        }];
        [UIView animateWithDuration:1 animations:^{
            self.giftImage.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }];
    });
    
    //执行
    dispatch_resume(self.timer);
    
}

-(void) stopAnimation {
    if (self.timer !=nil){
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
