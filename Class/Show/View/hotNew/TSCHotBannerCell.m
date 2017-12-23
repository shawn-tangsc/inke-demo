//
//  TSCHotBannerCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/17.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHotBannerCell.h"
#import "TSCBannerImageCell.h"
#import "TSCTicker.h"
#import "TSCTabBarViewController.h"
#define YYMaxSections 100
static NSString *bannerCellId = @"TSCBannerImageCell";

@interface TSCHotBannerCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) UICollectionView *bannerView;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) NSArray<TSCTicker *> *bannerlist;
@property (nonatomic, strong) NSTimer *timer;//另一种定时器
@end
@implementation TSCHotBannerCell
#pragma mark set
-(void)setData:(TSCHotSpecialData *)data{
    _data = data;
    _bannerlist = data.ticker;
    self.pageController.numberOfPages = _bannerlist.count;
}


#pragma mark lazy
-(UICollectionView *)bannerView{
    if(!_bannerView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH-10, (SCREEN_WIDTH-10)/726*200);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        _bannerView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, (SCREEN_WIDTH-10)/726*200) collectionViewLayout:layout];
        //默认的颜色是黑色
        _bannerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        _bannerView.dataSource = self;
        _bannerView.pagingEnabled = YES;
        _bannerView.showsHorizontalScrollIndicator = NO;
        _bannerView.delegate=self;
    }
    return _bannerView;
}

-(UIPageControl *)pageController{
    if(!_pageController){
        _pageController = [[UIPageControl alloc]init];
        _pageController.pageIndicatorTintColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1];
        _pageController.currentPageIndicatorTintColor = [UIColor colorWithRed:29.0/255.0 green:207.0/255.0 blue:186.0/255.0 alpha:1];
//        _pageController.numberOfPages = 3;//点不显示的话，看看是不是没设置numberOfPage
        
    }
    return _pageController;
}
#pragma mark init
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
    [self addTimer];
}
-(void) initUI{
    [self.backView addSubview:self.bannerView];
    [self.bannerView registerNib:[UINib nibWithNibName:@"TSCBannerImageCell" bundle:nil] forCellWithReuseIdentifier:bannerCellId];
//    [self.bannerView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:YYMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.bannerView.delegate = self;
    [self.backView addSubview:self.pageController];
//    self.bannerView.layer.cornerRadius = 5;
//    self.bannerView.layer.masksToBounds = YES;
    [self.pageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(0,15));
        make.centerX.equalTo(self.bannerView.mas_centerX);
    }];
}
#pragma mark 自动轮播计时器
-(void)addTimer{
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:t forMode:NSRunLoopCommonModes];
    self.timer = t;
}

-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark 自动轮播下一页
-(void)nextPage{
    NSIndexPath *currentIndexPath = [[self.bannerView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:YYMaxSections/2];
    [self.bannerView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem = currentIndexPathReset.item+1;
    NSInteger nextSection = currentIndexPathReset.section;//???
    if(nextItem == self.bannerlist.count){
        nextItem = 0 ;
        nextSection ++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.bannerView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//    self
}

#pragma mark collectionview 事件
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSCBannerImageCell *cell = [self.bannerView dequeueReusableCellWithReuseIdentifier:bannerCellId forIndexPath:indexPath];
    TSCTicker *t = self.bannerlist[indexPath.row];
    cell.imageUrl = t.image;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bannerlist.count;
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSCTicker *t = self.bannerlist[indexPath.row];
    if([t.link hasPrefix:@"http"]){
        NSLog(@"webview 跳转%@",t.link);
    }else {
        NSLog(@"内部跳转%@",t.link);
    }
}
#pragma mark 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat offset = scrollView.contentOffset.x;
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.bannerlist.count;
    self.pageController.currentPage = page;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return YYMaxSections;
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    CGPoint point = [[touches anyObject] locationInView:self.view];
////
////    if(CGRectContainsPoint(self.giftView.frame,point)){
////        NSLog(@"范围内");
////    }else {
////        [self.superController closeGiftView];
////    }
//    NSLog(@"self");
//}

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
