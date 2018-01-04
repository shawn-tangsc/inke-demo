//
//  TSCLoginViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/23.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCLoginViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <UMSocialCore/UMSocialCore.h>
#import "TSCTabBarViewController.h"
@interface TSCLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic, strong) UIView *mark;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *telBtn;
@property (nonatomic, strong) UIButton *qqBtn;
@property (nonatomic, strong) UIButton *weiboBtn;
@property (nonatomic, strong) UILabel *loginTitle;
@property (nonatomic, strong) UILabel *loginClause;
@property (nonatomic, strong) UILabel *clause;//27 210 190
@property (nonatomic, strong) UIView *clauseUnderLine;
@property (nonatomic, strong) UIView *clauseView;
@end

@implementation TSCLoginViewController
#pragma mark lazy
-(UIView *)clauseView{
    if(!_clauseView){
        _clauseView= [[UIView alloc]init];
    }
    return _clauseView;
}
-(UIView *)clauseUnderLine{
    if(!_clauseUnderLine){
        _clauseUnderLine = [[UIView alloc]init];
        _clauseUnderLine.backgroundColor = [UIColor colorWithRed:27.0/255.0 green:210.0/255.0 blue:190.0/255.0 alpha:1];
    }
    return _clauseUnderLine;
}

-(UILabel *)loginClause{
    if(!_loginClause){
        _loginClause = [[UILabel alloc]init];
        _loginClause.textColor = [UIColor whiteColor];
        _loginClause.text = @"登陆即代表你同意";
        _loginClause.font = [UIFont systemFontOfSize:11];
    }
    return _loginClause;
}
-(UILabel *)clause{
    if(!_clause){
        _clause = [[UILabel alloc]init];
        _clause.textColor = [UIColor colorWithRed:27.0/255.0 green:210.0/255.0 blue:190.0/255.0 alpha:1];
        _clause.text = @"映客服务和隐私条款";
        _clause.font = [UIFont systemFontOfSize:11];
    }
    return _clause;
}


-(UIButton *)weiboBtn{
    if(!_weiboBtn){
        _weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiboBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_weibo"] forState:UIControlStateNormal];
        [_weiboBtn addTarget:self action:@selector(weiboClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboBtn;
}

-(UIButton *)qqBtn{
    if(!_qqBtn){
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_qq"] forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(qqLoginClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

-(UIButton *)telBtn{
    if(!_telBtn){
        _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_telBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_phone"] forState:UIControlStateNormal];
    }
    return _telBtn;
}


-(UIButton *)wechatBtn{
    if(!_wechatBtn){
        _wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_wx"] forState:UIControlStateNormal];
        [_wechatBtn addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatBtn;
}

-(UILabel *)loginTitle{
    if(!_loginTitle){
        _loginTitle = [[UILabel alloc]init];
        [_loginTitle setText:@"选择登陆方式"];
        _loginTitle.font = [UIFont systemFontOfSize:13];
        _loginTitle.textColor = [UIColor whiteColor];
        
    }
    return _loginTitle;
}
-(UIView *)loginView{
    if(!_loginView){
        _loginView = [[UIView alloc] init];
    }
    return _loginView;
}

-(UIImageView *)logo{
    if(!_logo){
        _logo = [[UIImageView alloc]init];
        [_logo setImage:[UIImage imageNamed:@"login_logo"]];
    }
    return _logo;
}

-(UIView *)mark{
    if(!_mark){
        _mark = [[UIView alloc]init];
        _mark.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    }
    return _mark;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initPlayer];
    [self initUI];
}

-(void)initPlayer{
    //添加mp4到本地的时候，需要右键，add到target文件夹里，不然会返回nil
//    NSString *loginMP4 = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"m4a"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loginVideo.mp4" withExtension:nil];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.player = [[AVPlayer alloc]initWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+20);
    layer.videoGravity = AVLayerVideoGravityResize;//全屏
    [self.playerView.layer addSublayer:layer];
    self.player.volume = 1.0f;
    [self.player play];
    //注册通知类型
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runLoopMovie:(NSNotification *) n{
    AVPlayerItem * p = [n object];
    [p seekToTime:kCMTimeZero];//???
    [self.player play];
}

-(void)initUI{
    [self.view addSubview:self.mark];
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
        make.left.and.top.offset(0);
    }];
    [self.mark addSubview:self.logo];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mark.mas_centerX);
        make.top.offset(SCREEN_HEIGHT/2 - SCREEN_WIDTH/4.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4.5, SCREEN_WIDTH/4.5));
    }];
    [self.mark addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 140));
        make.bottom.offset(0);
    }];
    [self.loginView addSubview:self.loginTitle];
    [self.loginTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginView.mas_centerX);
        make.top.offset(5);
    }];
    [self.loginView addSubview:self.wechatBtn];
    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/9, SCREEN_WIDTH/9));
        make.left.offset(SCREEN_WIDTH/9);
        make.top.offset(SCREEN_WIDTH/9 -10);
    }];
    [self.loginView addSubview:self.telBtn];
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/9, SCREEN_WIDTH/9));
        make.left.equalTo(self.wechatBtn.mas_right).offset(SCREEN_WIDTH/9);
        make.centerY.equalTo (self.wechatBtn);
    }];
    [self.loginView addSubview:self.qqBtn];
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/9, SCREEN_WIDTH/9));
        make.left.equalTo(self.telBtn.mas_right).offset(SCREEN_WIDTH/9);
        make.centerY.equalTo (self.wechatBtn);
    }];
    [self.loginView addSubview:self.weiboBtn];
    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/9, SCREEN_WIDTH/9));
        make.left.equalTo(self.qqBtn.mas_right).offset(SCREEN_WIDTH/9);
        make.centerY.equalTo (self.wechatBtn);
    }];
    [self.loginView addSubview:self.clauseView];
    [self.clauseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.loginClause.text.length *11 + self.clause.text.length*11, 20));
        make.top.equalTo(self.weiboBtn.mas_bottom).offset(15);
    }];
    
    [self.clauseView addSubview:self.loginClause];
    [self.loginClause mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.offset(0);
    }];
    [self.clauseView addSubview:self.clause];
    [self.clause mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginClause.mas_right).offset(0);
        make.centerY.equalTo(self.loginClause.mas_centerY);
    }];
    [self.clauseView addSubview:self.clauseUnderLine];
    [self.clauseUnderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginClause.mas_right);
        make.top.equalTo(self.clause.mas_bottom).offset(-1);
        make.size.mas_equalTo(CGSizeMake(self.clause.text.length*11,0.5));
    }];
}

#pragma mark private
-(void)wechatLogin{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            self.view.window.rootViewController = [[TSCTabBarViewController alloc] init];
        }
    }];
}
- (void)qqLoginClick {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
             NSLog(@"%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            self.view.window.rootViewController = [[TSCTabBarViewController alloc] init];
        }
    }];
}
//模拟器上面没有微信 qq，所以做了一个后门，可以直接登陆
-(void)weiboClick{
    self.view.window.rootViewController = [[TSCTabBarViewController alloc] init];
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
