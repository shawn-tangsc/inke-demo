//
//  TSCHotViewControllerNew.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/16.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHotViewControllerNew.h"
#import "TSCRefreshHeader.h"
#import "TSCLiveHandler.h"
#import "TSCCards.h"
#import "TSCLiveSwiperCard.h"
#import "TSCHotSpecialCard.h"
#import "TSCHotLiveCell.h"
#import "TSCHotGameCell.h"
#import "TSCHotBannerCell.h"
#import "TSCHotSwiperLiveCell.h"
#import "TSCLiveSwiperCard.h"
#import "TSCPlayerViewController.h"
static NSString * liveId = @"TSCHotLive";
static NSString * gameId = @"TSCHotGame";
static NSString * swiperLiveId = @"TSCHotSwiperLive";
static NSString * bannerId = @"TSCHotBannerLive";


@interface TSCHotViewControllerNew ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *hotCollectionView;
@property (nonatomic,strong) NSMutableArray *datalist;
@end

@implementation TSCHotViewControllerNew

-(NSMutableArray *)datalist{
    if(!_datalist){
        _datalist = [[NSMutableArray alloc]init];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%f",SCREEN_WIDTH);
    NSLog(@"%f",self.view.frame.size.width);
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private function
-(void)initUI{
    [self.hotCollectionView registerNib:[UINib nibWithNibName:@"TSCHotLiveCell" bundle:nil] forCellWithReuseIdentifier:liveId];
    [self.hotCollectionView registerNib:[UINib nibWithNibName:@"TSCHotGameCell" bundle:nil] forCellWithReuseIdentifier:gameId];
    [self.hotCollectionView registerNib:[UINib nibWithNibName:@"TSCHotBannerCell" bundle:nil] forCellWithReuseIdentifier:bannerId];
    //swiperLiveId
    [self.hotCollectionView registerNib:[UINib nibWithNibName:@"TSCHotSwiperLiveCell" bundle:nil] forCellWithReuseIdentifier:swiperLiveId];
    //初始化下拉刷新
    TSCRefreshHeader *header = [TSCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    //隐藏状态
    header.stateLabel.hidden = YES;
    
    //马上进入刷新状态
    [header beginRefreshing];
    
    self.hotCollectionView.mj_header = header;
}

-(void)loadData{
    [TSCLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        [self.datalist removeAllObjects];
        NSArray *cards = [obj objectForKey:@"cards"];
        for (NSDictionary *card in cards) {
            NSNumber *style =card[@"cover"][@"style"];
            if(style.integerValue == 1 || style.integerValue == 2){
                TSCCards *liveCard = [TSCCards mj_objectWithKeyValues:card];
                [self.datalist addObject:liveCard];
            }else if (style.integerValue == 3){
                NSLog(@"3出现了");
            }else if (style.integerValue == 4){
                TSCLiveSwiperCard *liveSwiperCard =[TSCLiveSwiperCard mj_objectWithKeyValues:card];
                [self.datalist addObject:liveSwiperCard];
            }else if (style.integerValue == 5 || style.integerValue == 6){
                TSCHotSpecialCard *specialCard =[TSCHotSpecialCard mj_objectWithKeyValues:card];
                [self.datalist addObject:specialCard];
            }
        }
        [self.hotCollectionView reloadData];
        [self.hotCollectionView.mj_header endRefreshing];
    } failed:^(id obj) {
        NSLog(@"%@",obj);
        [self.hotCollectionView.mj_header endRefreshing];
    }];
}

#pragma mark - collectionView 事件
//(1)先告诉uicollectionview，有多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datalist.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'invalid nib registered for identifier (Cell) - nib must contain exactly one top level object which must be a UITableViewCell instance'"
    // http://www.jianshu.com/p/28c0132d39f7
    NSObject *card = self.datalist[indexPath.row];
    if([card isKindOfClass:[TSCCards class]]){
        TSCHotLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:liveId forIndexPath:indexPath];
        TSCCards * c = (TSCCards *)card;
        cell.live = c.data.liveInfo;
        return cell;
    }else if ([card isKindOfClass:[TSCHotSpecialCard class]]){
        TSCHotSpecialCard *c = (TSCHotSpecialCard *)card;
        if(c.cover.style == 5){
            TSCHotGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gameId forIndexPath:indexPath];
            cell.card = c;
            return cell;
        }else {
            TSCHotBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerId forIndexPath:indexPath];
            
            cell.data = c.data;
            return cell;
        }
    }else {
        TSCHotSwiperLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:swiperLiveId forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        TSCLiveSwiperCard * c = (TSCLiveSwiperCard *)card;
        cell.card = c;

        return cell;
    }
//    cell.layer.cornerRadius = 5;
//    cell.layer.masksToBounds = YES;
//
}
//(2)大小 ps:cell 之间的间距可以在xib的show the size inspector 中设置，cell和collectionview之间的边距可以设置section insets , cell之间的间距可以设置min spacing
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *card = self.datalist[indexPath.row];
    if ([card isKindOfClass:[TSCHotSpecialCard class]]){
        TSCHotSpecialCard *c = (TSCHotSpecialCard *)card;
        if(c.cover.style == 6){
//            CGFloat width = collectionView.width - 10 ;
//            CGFloat height = (SCREEN_WIDTH-10)/726*200 + 10;
            return CGSizeMake(collectionView.width - 10 ,(SCREEN_WIDTH-10)/726*200 + 15);
        }
    }
    CGFloat etraWidth = (collectionView.width - 15)/2;
    return CGSizeMake(etraWidth,etraWidth);
}


- (void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //调用这个cell的动画效果,(TSCNearliveCell *)为强制转换类型
//    TSCNearLiveCell * c = (TSCNearLiveCell *)cell;
//    [c showAnimation];
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
     NSObject *card = self.datalist[indexPath.row];
    if([card isKindOfClass:[TSCCards class]]){
        TSCCards * c = (TSCCards *)card;
        TSCPlayerViewController * playerVC = [[TSCPlayerViewController alloc] init];
        playerVC.live =c.data.liveInfo;
        [self.navigationController pushViewController:playerVC animated:YES];
    }else if ([card isKindOfClass:[TSCHotSpecialCard class]]){
        TSCHotSpecialCard *c = (TSCHotSpecialCard *)card;
        TSCTicker *t = c.data.ticker[0];
        if(c.cover.style == 5){
//            TSCHotGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gameId forIndexPath:indexPath];
//            cell.card = c;
//            return cell;
            if([t.link hasPrefix:@"http"]){
                NSLog(@"%@",t.link);
            }else {
                NSLog(@"%@",t.link);
            }
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    CGPoint point = [[touches anyObject] locationInView:self.view];
    NSLog(@"point");
//    if(CGRectContainsPoint(self.giftView.frame,point)){
//        NSLog(@"范围内");
//    }else {
//        [self.superController closeGiftView];
//    }
}


@end
