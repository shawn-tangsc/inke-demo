//
//  TSCGiftViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/6.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCGiftViewController.h"
#import "TSCLiveChatViewController.h"
#import "TSCGiftCell.h"
#import "TSCLiveHandler.h"
#import "TSCCollectionViewFlowLayout.h"

@interface TSCGiftViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *giftView;
@property (nonatomic, strong) TSCLiveChatViewController *superController;
@property (nonatomic, strong) UICollectionView *giftCollectionView;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) NSArray *gifts;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UIButton *sendBtn;
//@property (nonatomic, strong) UIView *coinView;
@property (nonatomic, strong) UIImageView *coinMarkImg;
@property (nonatomic, strong) UILabel *diamondCount;
@property (nonatomic, strong) UILabel *starCount;
@end

@implementation TSCGiftViewController
static NSString *const identifier = @"TSCGiftCell";

#pragma mark lazy
//-(UIView *)coinView{
//    if(!_coinView){
//        _coinView = [[UIView alloc] init];
//        _coinView.backgroundColor = [UIColor whiteColor];
//
//    }
//    return _coinView;
//}
-(UILabel *)starCount{
    if(!_starCount){
        _starCount = [[UILabel alloc]init];
        _starCount.text = @"9999999";
        _starCount.textColor = [UIColor colorWithRed:253.0/255.0 green:227.0/255.0 blue:180.0/255.0 alpha:1];
        _starCount.font = [UIFont systemFontOfSize:13];
    }
    return _starCount;
}
-(UILabel *)diamondCount{
    if(!_diamondCount){
        _diamondCount = [[UILabel alloc]init];
        _diamondCount.text = @"9999999";
        _diamondCount.textColor = [UIColor colorWithRed:243.0/255.0 green:194.0/255.0 blue:45.0/255.0 alpha:1];
        _diamondCount.font = [UIFont systemFontOfSize:13];
    }
    return _diamondCount;
}
-(UIImageView *)coinMarkImg{
    if(!_coinMarkImg){
        _coinMarkImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first_charge_icon"]];
    }
    return _coinMarkImg;
}
-(UIButton *)sendBtn{
    if(!_sendBtn){
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:214.0/255.0 blue:215.0/255.0 alpha:1];
        [_sendBtn setTitle:@"发 送" forState: UIControlStateNormal];
        _sendBtn.layer.cornerRadius = 15;
        _sendBtn.layer.masksToBounds = YES;
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        //设置字体
//        [_sendBtn setTitleEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];
        [_sendBtn setTintColor:[UIColor whiteColor]];//?
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn setTarget:self action:@selector(sendGift) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}
-(UIView *)btnView{
    if(!_btnView){
        _btnView = [[UIView alloc]init];
    }
    return _btnView;
}

-(UIPageControl *)pageController{
    if(!_pageController){
        _pageController = [[UIPageControl alloc]init];
        _pageController.pageIndicatorTintColor = [UIColor grayColor];
        _pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageController.backgroundColor = [UIColor redColor];

    }
    return _pageController;
}

-(UIView *)giftCollectionView{
    if(!_giftCollectionView){
        /**--------------1. 系统自带的排列方式是上下布局。---------------------*/
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        /**--------------2. 使用自定义的的排列方式是左右布局。---------------------*/
        TSCCollectionViewFlowLayout *layout = [[TSCCollectionViewFlowLayout alloc] initWithRowCount:2 itemCountPerRow:4];
        [layout setColumnSpacing:0 rowSpacing:0 edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置滚动方向
         /** 注意,此处设置的item的尺寸是理论值，实际是由行列间距、collectionView的内边距和宽高决定 */
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4, 124);//设置cell的size
        layout.minimumLineSpacing = 0;//行间距
        layout.minimumInteritemSpacing = 0;//同行之间item间距
        _giftCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 248) collectionViewLayout:layout];
        _giftCollectionView.dataSource = self;
        _giftCollectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        _giftCollectionView.pagingEnabled = YES;//是否可以类似page的滚动
        _giftCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _giftCollectionView;
}

#pragma mark function
-(TSCLiveChatViewController *)superController{
    if(!_superController){
        UIViewController *vc = [TSCCommonUtils superViewController:self];
        if ([vc isKindOfClass:[TSCLiveChatViewController class]])
        {
            _superController = (TSCLiveChatViewController *)vc;
        }
    }
    return _superController;
}

#pragma mark init
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self loadData];
}

-(void)loadData{
    NSString *status = [TSCCommonUtils getCurrentNetworkStatus];
    NSLog(@"%@",status);
    NSString * conn = nil;
    switch ([status intValue]) {
        case -1:
            conn = @"unknow";
            break;
        case 0:
            conn = @"no-network";
            break;
        case 1:
            conn = @"gprs";
            break;
        case 2:
            conn = @"wifi";
            break;
        default:
            break;
    }
    NSDictionary *data = @{@"osversion":[NSString stringWithFormat:@"ios_%f",IOS_VERSION],@"conn":conn,@"live_id":self.live.ID,@"live_uid":[NSString stringWithFormat:@"%ld",(long)self.live.actInfo.uid],@"uid":[NSString stringWithFormat:@"%ld",(long)self.live.creator.ID]};
    [TSCLiveHandler getLiveGiftsWithData:data success:^(id obj) {
        
        
        self.gifts = obj;
        TSCGifts *gift = self.gifts[0];
        gift.selected = YES;
        [self.giftCollectionView reloadData];
        //进位
        self.pageController.numberOfPages = (int)ceilf(self.gifts.count/8.0);
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
}

-(void) initUI{

// 下面这个代码是错误的，这样会导致视图上的所有子视图产生透明。
//    self.giftView.backgroundColor = [UIColor clearColor];
//    self.giftView.alpha = 0.5;
    self.giftView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    [self.giftView addSubview:self.giftCollectionView];
    [self.giftCollectionView registerNib:[UINib nibWithNibName:@"TSCGiftCell" bundle:nil] forCellWithReuseIdentifier: identifier];
    self.giftCollectionView.delegate = self;
    [self.giftView addSubview:self.pageController];
    
    [self.pageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(248);
        make.left.offset(SCREEN_WIDTH/2);
        make.size.mas_equalTo(CGSizeMake(0,15));
    }];
    [self.giftView addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(260);
        make.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,self.giftView.frame.size.height - 260 - 34));
    }];
    [self.btnView addSubview:self.sendBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.offset(-10);//????
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [self.btnView addSubview:self.coinMarkImg];
    [self.coinMarkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sendBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.left.offset(10);
    }];
    UILabel *coinLabel = [[UILabel alloc]init];
    coinLabel.text = @"首充";
    coinLabel.textColor = [UIColor colorWithRed:243.0/255.0 green:194.0/255.0 blue:45.0/255.0 alpha:1];
    coinLabel.font = [UIFont systemFontOfSize:14];
    [self.btnView addSubview:coinLabel];
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinMarkImg.mas_centerY);
        make.left.equalTo(self.coinMarkImg.mas_right).with.offset(2);
    }];
    UIImageView *payArrowImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pay_arrow"]];
    payArrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.btnView addSubview:payArrowImg];
    [payArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.width.equalTo(@19);
        make.centerY.equalTo(self.sendBtn.mas_centerY);
        make.left.equalTo(coinLabel.mas_right).offset(0);
    }];
    [self.btnView addSubview:self.diamondCount];
    [self.diamondCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinMarkImg.mas_centerY);
        make.left.equalTo(payArrowImg.mas_right).with.offset(2);
    }];
    UIImageView *diamondImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first_charge_reward_diamond"]];
   
    [self.btnView addSubview:diamondImg];
    [diamondImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sendBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13, 13));
        make.left.equalTo(self.diamondCount.mas_right).with.offset(2);
    }];
    [self.btnView addSubview:self.starCount];
    [self.starCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinMarkImg.mas_centerY);
        make.left.equalTo(diamondImg.mas_right).with.offset(2);
    }];
    UIImageView *starImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first_charge_reward_star"]];
    
    [self.btnView addSubview:starImg];
    [starImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sendBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13, 13));
        make.left.equalTo(self.starCount.mas_right).with.offset(2);
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//查找父控制器
- (UIViewController *)superViewController
{
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(void)sendGift {
    NSLog(@"送礼物");
}

#pragma mark 手势事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if(CGRectContainsPoint(self.giftView.frame,point)){
        NSLog(@"范围内");
    }else {
        [self.superController closeGiftView];
    }
}
#pragma mark collectionview 事件
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSCGiftCell *cell = [self.giftCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.gift = self.gifts[indexPath.row];
    if(cell.gift.isSelected == YES){
        cell.layer.borderWidth = 0.5;
        cell.layer.borderColor = [UIColor colorWithRed:65.0/255.0 green:214.0/255.0 blue:197.0/255.0 alpha:1].CGColor;
        [cell showAnimation];
    } else {
        cell.layer.borderColor =[UIColor colorWithRed:43.0/225.0 green:43.0/255.0 blue:59.0/225.0 alpha:1].CGColor;
        cell.layer.borderWidth = 0.3;
        [cell stopAnimation];
    }
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.gifts.count;
}
/** 点击事件*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [collectionView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    /** 单选效果，将所有的selected设置为no */
    for (TSCGifts *gift in self.gifts) {
        gift.selected = NO;
    }
    TSCGifts *gift = self.gifts[indexPath.row];
    gift.selected = YES;
    [self.giftCollectionView reloadData];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    self.pageController.currentPage = offset/SCREEN_WIDTH;
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
