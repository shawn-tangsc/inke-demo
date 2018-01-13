//
//  TSCHotSwiperLiveCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/17.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHotSwiperLiveCell.h"
#import "TSCCoverElements.h"
#import "TSCLiveSwiperChannel.h"
#import "TSCCover.h"
#import "TSCLive.h"
#import "TSCBannerImageCell.h"
#import "TSCHotViewControllerNew.h"
#import "TSCPlayerViewController.h"
#define YYMaxSections 100
static NSString *imageIconId = @"TSCBannerImageCell";
@interface TSCHotSwiperLiveCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) UIImageView *bottomImage;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *onlineUsers;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UILabel * cellName;
@property (nonatomic, strong) UILabel *onlineUsersText;
@property (nonatomic, strong) NSArray<UIImageView *> * userIcons;
@property (nonatomic, strong) NSArray<TSCLive *> *lives;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation TSCHotSwiperLiveCell
#pragma mark lazy
-(UICollectionView *)imageCollectionView{
    if(!_imageCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.size;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumInteritemSpacing = 0;
        _imageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
//        _imageCollectionView = [[UICollectionView alloc]init];
//        [_imageCollectionView setCollectionViewLayout:layout animated:YES];
        _imageCollectionView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:.0f];
        _imageCollectionView.dataSource = self;
        _imageCollectionView.pagingEnabled = YES;
        _imageCollectionView.showsHorizontalScrollIndicator = NO;
        _imageCollectionView.delegate = self;
        _imageCollectionView.scrollEnabled = NO;
    }
    return _imageCollectionView;
}
-(NSArray<UIImageView *> *)userIcons{
    if(!_userIcons){
        NSMutableArray<UIImageView *> * arrayTemp = [NSMutableArray array];
        for (int i =0; i<3; i++) {
            [arrayTemp addObject:[self getUserIcon]];
        }
        _userIcons = [NSArray arrayWithArray:arrayTemp];
    }
    return _userIcons;
}
//为userIcons 填值
-(UIImageView *)getUserIcon{
    UIImageView *userIcon =[[UIImageView alloc]init];
    userIcon.layer.cornerRadius = 13;
    userIcon.layer.masksToBounds = YES;
    userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    userIcon.layer.borderWidth = 1;
    return userIcon;
}

-(UIImageView *)iconImage{
    if(!_iconImage){
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}
-(UILabel *) cellName{
    if(!_cellName){
        _cellName = [[UILabel alloc]init];
        _cellName.textColor = [UIColor whiteColor];
        _cellName.font = [UIFont systemFontOfSize:13];
    }
    return _cellName;
}
-(UILabel *)onlineUsers{
    if(!_onlineUsers){
        _onlineUsers = [[UILabel alloc]init];
        _onlineUsers.textColor = [UIColor whiteColor];
        _onlineUsers.font = [UIFont systemFontOfSize:12];
    }
    return _onlineUsers;
}
-(UILabel *)onlineUsersText{
    if(!_onlineUsersText){
        _onlineUsersText = [[UILabel alloc]init];
        _onlineUsersText.text = @"人正在看";
        _onlineUsersText.textColor = [UIColor whiteColor];
        _onlineUsersText.font = [UIFont systemFontOfSize:9];
    }
    return _onlineUsersText;
}
-(UIImageView *)bottomImage{
    if(!_bottomImage){
        _bottomImage = [[UIImageView alloc]init];
    }
    return _bottomImage;
}
-(UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8];
    }
    return _lineView;
}


#pragma mark setCard
-(void)setCard:(TSCLiveSwiperCard *)card{
    _card = card;
    _lives = card.data.channel.cards;
    [self clearItme];
    [self initUI];
    [self addConstraintsForUI];
}
#pragma mark 还是那个问题，cell复用的时候出现内容乱串的问题，所以在return cell的时候把cell.contentView.subview全部remove掉，在这里最好再把所有的item清空，不然问题很多
-(void)clearItme{
    _imageCollectionView = nil;
    _bottomImage = nil;
    _iconImage = nil;
    _onlineUsers = nil;
    _lineView = nil;
    _cellName = nil;
    _onlineUsersText = nil;
    _userIcons = nil;
    [self removeTimer];
}

#pragma mark 添加约束
-(void) addConstraintsForUI{
    NSArray *elements = self.card.cover.elements;
    NSString *iconurl = nil;
    for (int i=0; i<3; i++) {
        TSCCoverElements *element =elements[i];
        switch (i) {
            case 0:
                [self.bottomImage downloadImage:element.bgImage placeholder:nil];
                if(element.icon){
                    iconurl = element.icon[0];
                    [self.iconImage downloadImage:element.icon[0] placeholder:nil];
                }
                self.cellName.text = element.text;
                break;
            case 1:
                self.onlineUsers.text = element.text;
                break;
            case 2:
                self.onlineUsersText.text = element.text;
                break;
            default:
                break;
        }
    }
    [self.imageCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.size.width,self.size.height));
    }];
    [self.bottomImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(self.size.height/5*4);
        make.left.and.right.and.bottom.offset(0);
    }];
    
    /**
     *  这里敲黑板！！！！！！http://blog.csdn.net/godblessmyparents/article/details/51869264
     1.mas_makeConstraints 只负责新增约束,Autolayout 不能同时存在两条针对于同一对象约束 否则会就会布局错乱！！！而复用cell的时候，由于此方法是由setCard方法触发，所以每次复用都会执行这里，之前的make已经存在了，所以再使用mas_makeConstraints 就会出现复用的时候出现问题
     2.mas_remakeConstraints 会清除之前的所有约束 仅保留最新的约束！！
     */
    [self.iconImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(5);
        if(iconurl){
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }else{
            make.size.mas_equalTo(CGSizeMake(0, 15));
        }
    }];
    [self.cellName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(iconurl?5:0);
        make.centerY.equalTo(self.iconImage.mas_centerY);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat iconLenth =iconurl?20:0;
        CGFloat width = [self.cellName.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width;
        make.size.mas_equalTo(CGSizeMake(width+iconLenth, 2));
        make.top.equalTo(self.cellName.mas_bottom).offset(3);
        make.left.offset(10);
    }];
    [self.onlineUsersText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.centerY.equalTo(self.lineView.mas_centerY).offset(2);
    }];
    [self.onlineUsers mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.onlineUsersText.mas_left);
        make.centerY.equalTo(self.onlineUsersText.mas_centerY);
    }];
    if(self.lives.count >1){
        for (int i=0; i<3; i++) {
            TSCLive *live = self.lives[i];
            [self.userIcons[i] downloadImage:live.creator.portrait placeholder:@"default_room"];
        }
        for(int i = 2 ; i >= 0; i--){
            if(i == 2){
                [self.userIcons[2] mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(26, 26));
                    make.top.offset(-10);
                    make.right.offset(-5);
                }];
            }else if(i == 1){
                [self.userIcons[1] mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(26, 26));
                    make.right.equalTo(self.userIcons[2].mas_right).offset(-15);
                    make.centerY.equalTo(self.userIcons[2].mas_centerY);
                }];
            }else {
                [self.userIcons[0] mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(26, 26));
                    make.centerY.equalTo(self.userIcons[2].mas_centerY);
                    make.right.equalTo(self.userIcons[1].mas_right).offset(-15);
                }];
            }
        }
        [self addTimer];
    }else{
        TSCLive *live = self.lives[0];
        [self.userIcons[0] downloadImage:live.creator.portrait placeholder:@"default_room"];
    }

}

#pragma mark init
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
    
}
-(void)initUI{
    [self.contentView addSubview:self.imageCollectionView];
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"TSCBannerImageCell" bundle:nil] forCellWithReuseIdentifier:imageIconId];
    [self.contentView addSubview:self.bottomImage];
    [self.bottomImage addSubview:self.iconImage];
    [self.bottomImage addSubview:self.cellName];
    [self.bottomImage addSubview:self.lineView];
    [self.bottomImage addSubview:self.onlineUsersText];
    [self.bottomImage addSubview:self.onlineUsers];
    for(int i = 2 ; i >= 0; i--){
        [self.bottomImage addSubview:self.userIcons[i]];
    }
}

#pragma mark 自动轮播计时器
-(void)addTimer{
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:t forMode:NSRunLoopCommonModes];
    self.timer = t;
}

-(void) removeTimer{
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)nextPage{
    //注意注意注意！！这种写法，如果当collectionview的显示窗口小于屏幕的一半时，其实视图中会有两张cell，indexPathsForVisibleItems 无法准确的获取，
//    NSIndexPath *currentIndexPath = [[self.imageCollectionView indexPathsForVisibleItems] lastObject];
    
    
    // 将collectionView在控制器view的中心点转化成collectionView上的坐标
    CGPoint pInView = [self.contentView convertPoint:self.imageCollectionView.center toView:self.imageCollectionView];
    // 获取这一点的indexPath
    NSIndexPath *currentIndexPath = [self.imageCollectionView indexPathForItemAtPoint:pInView];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:YYMaxSections/2];
    [self.imageCollectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem = currentIndexPathReset.item+1;
    NSInteger nextSection = currentIndexPathReset.section;//???
    if(nextItem == self.lives.count){
        nextItem = 0 ;
        nextSection ++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.imageCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    //    self
}
#pragma mark 当用户停止的时候调用
//-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if(self.lives.count>1){
//          [self addTimer];
//    }
//}
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self removeTimer];
//}

#pragma mark collectionview 事件
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSCBannerImageCell *cell = [self.imageCollectionView dequeueReusableCellWithReuseIdentifier:imageIconId forIndexPath:indexPath];
    TSCLive *live = self.lives[indexPath.row];
    cell.imageUrl = live.creator.portrait;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.lives.count;
}
// 指定Section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //这里制定100个section个数
    return YYMaxSections;
}
//item 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    UIView *view =
//    TSCHotViewControllerNew *c = (TSCHotViewControllerNew *)[TSCCommonUtils getSuperViewController:@"TSCHotViewControllerNew" target:self];
    TSCHotViewControllerNew *c =(TSCHotViewControllerNew *)[self getTSCHotViewControllerNew];
    TSCLive *live = self.lives[indexPath.row];
    TSCPlayerViewController * playerVC = [[TSCPlayerViewController alloc] init];
    playerVC.live =live;
    if(c){
        [c.navigationController pushViewController:playerVC animated:YES];
    }
}


#pragma mark 这里设置cell的尺寸会导致[self.imageCollectionView indexPathsForVisibleItems]获取不到1后面的值
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.size;
}

#pragma mark privateFun
- (UIViewController *)getTSCHotViewControllerNew
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[TSCHotViewControllerNew class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
