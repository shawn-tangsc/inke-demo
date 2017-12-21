//
//  TSCLiveChatViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/28.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCLiveChatViewController.h"
#import "TSCLiveHandler.h"
#import "TSCGiftViewController.h"
#import "TSCPlayerViewController.h"
@interface TSCLiveChatViewController ()

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UIButton *headBtn;
@property (nonatomic,strong) UIView *headImageBackground;
@property (nonatomic,strong) UIButton *follow;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *onlineUsers;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *giftBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) NSArray *heartList;
@property (nonatomic) CGPoint gestureStartPoint;
//@property (weak, nonatomic) IBOutlet UIScrollView *usersScrollView;
//@property (weak, nonatomic) IBOutlet UILabel *creatorId;
@property (nonatomic, strong) NSMutableArray *usersList;
@property (nonatomic, strong) UIScrollView * usersScrollView;
@property (nonatomic, strong) UILabel *creatorId;
@property (weak, nonatomic) IBOutlet UIView *liveChatView;
@property (nonatomic, strong) TSCGiftViewController *giftView;
@property (nonatomic, strong) TSCPlayerViewController *playerVC;


@end

@implementation TSCLiveChatViewController

-(TSCPlayerViewController *)playerVC{
    if(!_playerVC){
        UIViewController *vc = [TSCCommonUtils superViewController:self];
        if ([vc isKindOfClass:[TSCPlayerViewController class]])
        {
            _playerVC = (TSCPlayerViewController *)vc;
        }
    }
    return _playerVC;
}

-(TSCGiftViewController *)giftView {
    if(!_giftView){
        _giftView = [[TSCGiftViewController alloc]init];
        _giftView.live = self.live;
    }
    return _giftView;
}

-(UILabel *)creatorId{
    if(!_creatorId){
        _creatorId = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 80, SCREEN_WIDTH/2 - 15, 20)];
        [_creatorId setFont: [UIFont systemFontOfSize:14]];
        _creatorId.textAlignment = NSTextAlignmentRight;
        [_creatorId setTextColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1]];
    }
    return _creatorId;
}

-(UIScrollView *)usersScrollView{
    if(!_usersScrollView){
        _usersScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -185 , 40, 175, 30)];
        _usersScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _usersScrollView;
}
-(NSMutableArray *)usersList{
    if(!_usersList){
        _usersList = [[NSMutableArray alloc]init];
    }
    return _usersList;
}

-(NSArray *)heartList{
    if(!_heartList){
        _heartList = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5"];
    }
    return _heartList;
    
}
-(UIView *)headImageBackground{
    if(!_headImageBackground){
        _headImageBackground = [[UIView alloc]initWithFrame:CGRectMake(10, 40, 130, 30)];
        _headImageBackground.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.2];
        _headImageBackground.layer.cornerRadius = 15;
        _headImageBackground.layer.masksToBounds = YES;
    }
    return _headImageBackground;
}

-(UILabel *)name{
    if(!_name){
        _name = [[UILabel alloc] initWithFrame:CGRectMake(45, 40, 50, 15)];
        _name.textColor = [UIColor whiteColor];
        _name.font = [UIFont systemFontOfSize:10];
        
    }
    return _name;
}

-(UILabel *)onlineUsers{
    if(!_onlineUsers){
        _onlineUsers = [[UILabel alloc] initWithFrame:CGRectMake(45, 55, 50, 15)];
        _onlineUsers.textColor = [UIColor whiteColor];
        _onlineUsers.font = [UIFont systemFontOfSize:10];

    }
    return _onlineUsers;
}

-(UIButton *)follow{
    if(!_follow){
        _follow = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [_follow setTitle:@"关注" forState: UIControlStateNormal];
         _follow.frame = CGRectMake(95, 45, 40, 20);
//        [_follow setTitleEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_follow setBackgroundColor:[UIColor colorWithRed:40.0/255.0 green:214.0/255.0 blue:198.0/255.0 alpha:1]];
        _follow.layer.cornerRadius = _follow.size.height / 2;
        _follow.layer.masksToBounds = YES;
        _follow.titleLabel.font = [UIFont systemFontOfSize:12];
         [_follow setTintColor:[UIColor blackColor]];
        [_follow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_follow addTarget:self action:@selector(followAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _follow;
}

-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 30, 30)];
        _headImage.layer.cornerRadius = 15;
        _headImage.layer.masksToBounds = YES;
        //以下是为image注册点击事件
        //当视图对象的userInteractionEnabled设置为NO的时候，用户触发的事件，如触摸，键盘等，将不会被该视图忽略（其他视图照常响应）
//        _headImage.userInteractionEnabled = YES;
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personView:)];
//        [_headImage addGestureRecognizer:singleTap];
    }
    return _headImage;
}
-(UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *headImg = self.headImage.image;
//        [_headBtn setImage:headImg forState:UIControlStateNormal];

        _headBtn.frame = CGRectMake(10, 40, 30, 30);
        [_headBtn addTarget:self action:@selector(personView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}

-(void) followAction{
    [self.follow setHidden:YES];
    NSLog(@"关注被点击了");
    [UIView animateWithDuration:0.5 animations:^{
        self.headImageBackground.width = 100.f;
    }];
}

-(void)personView:(UIButton*)btn{
    NSLog(@"头像被点击了");
}

-(void)setLive:(TSCLive *)live{
    _live = live;
    [self.headImage downloadImage:live.creator.portrait placeholder:@"default_room"];
    [self.name setText:live.creator.nick];
    self.creatorId.text =[NSString stringWithFormat:@"映客号:%ld",(long)live.creator.ID];
    //注意set两次会报错
//    [self.onlineUsers setText:[NSString stringWithFormat:@"%ld",live.onlineUsers]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self setUserToScroll];
    
}
-(void) initUI{
    [self.view addSubview:self.headImageBackground];
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.headBtn];
    [self.view addSubview:self.follow];
    [self.view addSubview:self.name];
    [self.view addSubview:self.onlineUsers];
    [self.view addSubview:self.creatorId];
    [self.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.giftBtn addTarget:self action:@selector(gift) forControlEvents:UIControlEventTouchUpInside];
    [self.messageBtn addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    [self.chatBtn addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildVC];
}
-(void) addChildVC{
    [self addChildViewController:self.giftView];
    [self.view addSubview:self.giftView.view];
    [self.giftView.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.and.bottom.equalTo(self.view);
//        make.top.equalTo(self.view).with.offset(SCREEN_HEIGHT);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_HEIGHT, SCREEN_HEIGHT));
        make.top.offset(SCREEN_HEIGHT);
    }];
}

-(void) setUserToScroll {
    if(!self.live.ID){
        return;
    }
    NSDictionary *data = @{@"id":self.live.ID,@"start":@"0",@"count":@"20"};
    [TSCLiveHandler getLiveUsersWithData:data success:^(id obj) {
        NSLog(@"%@",obj[@"total"]);
        [self.onlineUsers setText:[NSString stringWithFormat:@"%@",obj[@"total"]]];
        NSArray *creators = [TSCCreator mj_objectArrayWithKeyValuesArray:obj[@"users"]];
        for (TSCCreator *creator in creators) {
            UIImageView *userImgView = [[UIImageView alloc] init];
            NSString *url = [creator.portrait hasPrefix:@"http"] ?creator.portrait : [NSString stringWithFormat:@"%@%@",RESOURCE_HOST,creator.portrait];
            [userImgView downloadImage:url placeholder:@"default_room" success:^(UIImage *image) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(self.usersList.count * 35, 0, 30, 30);
                [btn setImage:image forState:UIControlStateNormal];
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = 15;
                self.usersScrollView.contentSize = CGSizeMake(35.0 * self.usersList.count +30, 30);
                [self.usersScrollView addSubview:btn];
                [self.usersList addObject:btn];
            } failed:^(NSError *error) {
                NSLog(@"%@",error);
            } progress:^(CGFloat progress) {
//                NSLog(@"%f",progress);
            }];
        }
//        self.usersScrollView.contentSize = CGSizeMake(35.0 * self.usersList.count, 30);
//        self.usersScrollView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:self.usersScrollView];
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
}

- (void) share{
    NSLog(@"分享");
}

- (void) gift{
    NSLog(@"礼物");
//    [self addChildVC];
    self.liveChatView.hidden = YES;
    self.playerVC.closeBtn.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.giftView.view.origin = CGPointMake(0, 0);
    }];
}

-(void) message{
    NSLog(@"信息");
}

-(void)chat{
    NSLog(@"聊天");
}
//关闭礼物界面
-(void) closeGiftView{
    [UIView animateWithDuration:0.5 animations:^{
        self.giftView.view.origin = CGPointMake(0, SCREEN_HEIGHT);
    }];
    self.liveChatView.hidden = NO;
    self.playerVC.closeBtn.hidden = NO;
}

//定时器
-(void) initTimer{
    // 创建GCD定时器
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    // 开始时间 DISPATCH_TIME_NOW ，提交时间 1 * NSEC_PER_SEC（一秒后）
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{//设置响应dispatch源事件的block，在dispatch源指定的队列上运行
        [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
    });
    
    //执行
    dispatch_resume(self.timer);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.gestureStartPoint = [touch locationInView:self.view];
    [super touchesBegan:touches withEvent:event];
}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self.view];
    if(fabs(self.gestureStartPoint.x-endPoint.x)<5&&fabs(self.gestureStartPoint.y-endPoint.y)<5 ){
        [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
    }
}

//触发爱心事件
-(void) showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];//先初始化一个图片，固定一个宽高
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:addToView];//作用就是计算addToView上的fromView相对于addToView的frame。
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);//计算图片的初始化位置
    imageView.layer.position = position;//重新绘制图片位置
    NSInteger imgIndex = arc4random() % 5;//0～4之间取随机数
    imageView.image = [UIImage imageNamed:self.heartList[imgIndex]];
    [addToView addSubview:imageView];
    
    
    //下面是一个让图片从小到大的一种显示方式
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);//设置imageView的x和y的缩放比例
    //这个方法可以有一个弹簧式的移动时间曲线，如果usingSpringWithDamping 为1，则动画会平稳的衰减到他的最终形态（不会震荡），如果usingSpringWithDamping小于1，在结束前会有一个加速度的过程，你可以通过initialSpringVelocity来决定模拟弹簧末端的物体在连接之前有多快移动，UIViewAnimationOptionCurveEaseOut 时间曲线函数，由快到慢
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;//还原对象
    } completion:nil];
    //下面是移动部分
    CGFloat duration = 3 + arc4random()%5;
    //是CApropertyAnimation的子类，跟CABasicAnimation的区别是：CABasicAnimation只能从一个数值(fromValue)变到另一个数值(toValue)，而CAKeyframeAnimation会使用一个NSArray保存一些数值，里面的元素称为“关键帧”。动画对象会在制定的时间（duration）内，依次显示values数组中的每一个关键帧。
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;//执行关键帧的周期次数。
    positionAnimate.duration = duration;//设置一个周期的时间
    //fillMode的作用就是决定当前对象过了非active时间段的行为
    positionAnimate.fillMode = kCAFillModeForwards; //当动画结束后，layer会一直保持着动画最后的状态
    positionAnimate.removedOnCompletion = NO; //将其removedOnCompletion设置为NO,要不然fillMode不起作用.
    //贝塞尔曲线
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];//如果你希望在不绘制任何线条的情况下移动currentPoint, 你可以使用 moveToPoint:方法.起始位置http://www.jianshu.com/p/6130b51a0b71
    
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1; //随机取-1和1之间的数
    CGFloat controlPointValue = (arc4random()%50 +arc4random()%100)*sign;//取一个-148～148之间的数
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x-controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x +controlPointValue, position.y - 150)];//设置贝塞尔曲线
    positionAnimate.path = sPath.CGPath;
    
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
