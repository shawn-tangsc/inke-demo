//
//  TSCAdvertiseView.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/14.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCAdvertiseView.h"
#import "TSCCommonHandler.h"
#import "TSCAdvertisingData.h"
#import "TSCAdvertisingRecord.h"
#import "TSCCacheHelper.h"
#import "UIImageView+WebCache.h"//????
#import "NSString+CachePath.h"
#import "SDWebImageManager.h"
#import "SDImageCacheConfig.h"
#import <SDImageCache.h>
static int showtime = 3;

@interface TSCAdvertiseView()
@property (nonatomic, strong) TSCAdvertisingData *advertise;
@property (nonatomic, strong) UIImageView *advertiseImage;
@property (nonatomic, strong) UIButton *skipBtn;
@property (nonatomic, strong) dispatch_source_t timer;
//@property (nonatomic, strong)
//@property (weak, nonatomic) IBOutlet UIImageView *advertiseImage;

//@property (weak, nonatomic) IBOutlet UILabel *skipTime;
@end

@implementation TSCAdvertiseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)setAdvertise:(TSCAdvertisingData *)advertise{
//    _advertise = advertise;
//    TSCAdvertisingRecord *record = advertise.record[0];
//
//}
-(UIButton *)skipBtn{
    if(!_skipBtn){
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _skipBtn.layer.borderWidth = 0.3;
        _skipBtn.layer.cornerRadius = 15;
        _skipBtn.layer.masksToBounds = YES;
        _skipBtn.titleLabel.text = @"跳过";
        [_skipBtn setTitle:@"跳过" forState: UIControlStateNormal];
        [_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_skipBtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}

-(UIImageView *)advertiseImage{
    if(!_advertiseImage){
        _advertiseImage = [[UIImageView alloc]init];
    }
    return _advertiseImage;
}
/**
 因为uiview没有直接的xib文件，如果你要用自己创建一个view的话，除了在xib里面绑定以外，还需要通过 [[[NSBundle mainBundle] loadNibNamed:@"TSCAdvertiseView" owner:self options:nil] lastObject]方式来初始化
 */
+(instancetype) loadAdvertiseView{
    return [[[NSBundle mainBundle] loadNibNamed:@"TSCAdvertiseView" owner:self options:nil] lastObject];//????
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"TSCAdvertiseView" owner:nil options:nil];
        self = [nibs objectAtIndex:0];
        self.frame = frame;
    }
    return self;
}

-(void)skip{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self showAd];
    [self downloadAd];
    [self startTimer];
//    [self currentTimeStr];
    
}

#pragma mark 展示广告,先看看缓存里面是否有
-(void)showAd{
//    TSCAdvertisingRecord *record = self.advertise.record[0];
    TSCAdvertisingRecord * record = [TSCCacheHelper getAdvertise];
//    NSString * filePath = file;
    NSInteger time = [self currentTime];
//    SDImageCache * ca=[SDWebImageManager sharedManager].imageCache;
    UIImage *lastPreviousCachedImage = [[SDWebImageManager sharedManager].imageCache  imageFromDiskCacheForKey:record.img];
    
   
    if(time<record.dStart||!lastPreviousCachedImage){
        self.hidden = YES;
    }else {
         //因为设置图片缓存过期时间的方法有点问题，所以只能通过自己写的清理缓存的方法手动清理缓存。
        if(time>record.dEnd){
            self.hidden = YES;
            [self clearCache:record.img];
        }else{
            self.advertiseImage.image = lastPreviousCachedImage;
            [self addSubview:self.advertiseImage];
            [self.advertiseImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.top.and.bottom.and.right.mas_equalTo(0);
            }];
            [self addSubview:self.skipBtn];
            [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-15);
                make.top.offset(LL_iPhoneX?55:25);
                make.size.mas_equalTo(CGSizeMake(50, 30));
            }];
        }
    }
}

#pragma mark 下载广告
-(void)downloadAd{
    [TSCCommonHandler getAdvertisingWithSuccess:^(id obj) {
        self.advertise = (TSCAdvertisingData *) obj;
        TSCAdvertisingRecord *record = self.advertise.record[0];
        NSURL * imageUrl = [NSURL URLWithString:record.img];
        //SDWebImageAvoidAutoSetImage 下载后不给imageview赋值
//       http://blog.csdn.net/wangfeng2500/article/details/50331203
        SDWebImageManager *manager =[SDWebImageManager sharedManager];
        
        //我也不知道下面这么写能不能设置图片缓存的过期时间，查了很多资料都没试出来，留给以后再研究吧。。。。。
        [manager.imageCache.config setMaxCacheAge:record.dEnd - [self currentTime]];

        [manager loadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL)  {
            [TSCCacheHelper setAdvertiseRecord:record];
             NSLog(@"图片下载成功");
        }];//???
        NSLog(@"%@",obj);
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
}
// nstimer 因为线程的关系并不精准
-(void) startTimer{
    __block NSUInteger timeout = showtime+1;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    self.timer = timer;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self skip];
            });
        } else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_skipBtn setTitle:[NSString stringWithFormat:@"跳过%zd",timeout] forState: UIControlStateNormal];
//                self.skipBtn.titleLabel.text = [NSString stringWithFormat:@"跳过%zd",timeout];
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

- (NSInteger)currentTime{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval interval=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    NSInteger time = interval;
    return time;
}


-(void) clearCache:(NSString *)url{
    //异步清除图片缓存 （磁盘中的）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[SDImageCache sharedImageCache] removeImageForKey:url withCompletion:^{
            NSLog(@"%@清理掉了",url);
        }];
    });
}

@end
