//
//  TSCPlayerViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/26.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "TSCLiveChatViewController.h"
#import "AppDelegate.h"
@interface TSCPlayerViewController ()
@property(atomic, retain) id<IJKMediaPlayback> player;
@property(nonatomic, strong) UIImageView * blurImageView;

@property(nonatomic,strong) TSCLiveChatViewController * liveChatVC;
@property(nonatomic) CGPoint beganPoint;
@property(nonatomic) BOOL liveChatVCIsHide;
@end

@implementation TSCPlayerViewController


-(TSCLiveChatViewController *) liveChatVC {
    if(!_liveChatVC){
        _liveChatVC = [[TSCLiveChatViewController alloc]init];
        
    }
    return _liveChatVC;
}

-(UIButton *)closeBtn {
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeBtn sizeToFit];
        CGFloat btnY = SCREEN_HEIGHT -_closeBtn.height -10 ;
        if(LL_iPhoneX){
            btnY= self.liveChatVC.toolView.frame.origin.y +10;
        };
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH - _closeBtn.width - 10, btnY , _closeBtn.width, _closeBtn.height);
        //outside 就没用了
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
-(void)closeAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //注册直播需要用的通知
    [self installMovieNotificationObservers];
    //准备播放
    [self.player prepareToPlay];
    //[UIApplication sharedApplication].delegatewindow 也可以
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
//    UIWindow * w = [UIApplication sharedApplication].delegate
    [keyWindow addSubview:self.closeBtn];
}
//这里如果是didDisappear的话就无法触发navigationBarHidden = NO ？
- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.player shutdown];
    [self removeMovieNotificationObservers];
    [self.closeBtn removeFromSuperview];
}
-(void)installMovieNotificationObservers
{
    //监听网络环境，监听缓冲方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    //监听直播是否完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    //监听用户操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}
- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,未知
    //    MPMovieLoadStatePlayable       = 1 << 0, 缓冲结束可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES 缓冲结束自动播放
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started暂停状态
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    self.blurImageView.hidden = YES;
    [self.blurImageView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPlayer];
    [self initUI];
    [self addChildVC];
//    [self addSwipeGuest];
}
//Masonry介绍与使用实践 http://www.cocoachina.com/ios/20141219/10702.html
-(void)addChildVC{
     self.liveChatVC.live = self.live;
    [self addChildViewController:self.liveChatVC];
    //在使用mas_makeConstraints 时，一定要先将view添加到superview上 否则会报错
    [self.view addSubview:self.liveChatVC.view];
    //mas_makeConstraints只负责新增约束 Autolayout不能同时存在两条针对于同一对象的约束 否则会报错,如果需要重新更新约束，需要mas_updateConstraints，这样就不会导致出现两个相同约束的情况。mas_remakeConstraints 可以清除之前所有约束，仅保留最新的约束。
    [self.liveChatVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);//边缘相等
    }];
}

//毛玻璃效果
-(void) initUI {
    self.view.backgroundColor = [UIColor blackColor];
    self.blurImageView =[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.blurImageView downloadImage:[NSString stringWithFormat:@"%@",self.live.creator.portrait] placeholder:@"default_room"];
    [self.view addSubview:self.blurImageView];
    //创建毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建毛玻璃视图
    UIVisualEffectView * ve = [[UIVisualEffectView alloc]initWithEffect:blur];
    ve.frame = self.blurImageView.bounds;
    //毛玻璃效果覆盖
    [self.blurImageView addSubview:ve];

}
-(void) initPlayer {
    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.live.streamAddr withOptions:options];
    self.player = player;
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -监听触摸事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"触摸开始了");
    UITouch* touch = [touches anyObject];
    CGPoint began = [touch locationInView:self.view];
    self.beganPoint = began;
//    NSLog(@"%f",self.liveChatVC.view.origin.x);
    self.liveChatVCIsHide = self.liveChatVC.view.origin.x == 0 ? NO : YES;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"移动中");
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGFloat distanceX =currentPoint.x - self.beganPoint.x;
    CGFloat distanceY =currentPoint.y - self.beganPoint.y;
//    NSLog(@"%@", self.liveChatVCIsHide?@"YES":@"NO");
    if(fabs(distanceX) > fabs(distanceY)){
        if(!self.liveChatVCIsHide&&distanceX>=0){
//            NSLog(@"向右滑");
            self.liveChatVC.view.origin = CGPointMake(distanceX, 0);
        }else if (self.liveChatVCIsHide&&distanceX<0){
            self.liveChatVC.view.origin = CGPointMake(SCREEN_WIDTH + distanceX, 0);
//             NSLog(@"向左滑");
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"移动结束");
    UITouch* touch = [touches anyObject];
    CGPoint end = [touch locationInView:self.view];
    CGFloat distanceX =end.x - self.beganPoint.x;
    CGFloat distanceY =end.y-self.beganPoint.y;
//    NSLog(@"x=%f,y=%f",end.x,end.y);
    if(fabs(distanceX) > fabs(distanceY)){
        if(!self.liveChatVCIsHide){
            if(distanceX<50){
                [UIView animateWithDuration:0.5 animations:^{
                    self.liveChatVC.view.origin = CGPointMake(0, 0);
                }];
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    self.liveChatVC.view.origin = CGPointMake(SCREEN_WIDTH, 0);
                }];
            }
//            NSLog(@"向右滑");
        }else if (self.liveChatVCIsHide&&distanceX<0){
            NSLog(@"%f",distanceX);
            if(distanceX>-50){
                [UIView animateWithDuration:0.5 animations:^{
                    self.liveChatVC.view.origin = CGPointMake(SCREEN_WIDTH, 0);
                }];
            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    self.liveChatVC.view.origin = CGPointMake(0, 0);
                }];
            }
//            NSLog(@"向左滑");
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
