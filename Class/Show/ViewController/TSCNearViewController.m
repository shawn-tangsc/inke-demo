//
//  TSCNearViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/5.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCNearViewController.h"
#import "TSCLiveHandler.h"
#import "TSCLocationManager.h"
#import "TSCNearLiveCell.h"
#import "TSCFlow.h"
#import "TSCPlayerViewController.h"
#import "TSCRefreshHeader.h"

static NSString * identifier = @"TSCNearLiveCell";

#define kMargin 8
#define kItemWidth 125
@interface TSCNearViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>//设置这两个的时候，不要忘记要在xib中Show the connections inspctor 中将dataSource 和 Delegate 绑定到Files owner上面
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray * datalist;
@end

@implementation TSCNearViewController
//（4）每个Cell将要显示的时候出现
- (void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //调用这个cell的动画效果,(TSCNearliveCell *)为强制转换类型
    TSCNearLiveCell * c = (TSCNearLiveCell *)cell;
    [c showAnimation];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    TSCFlow *flow =self.datalist[indexPath.row];
    
    TSCPlayerViewController * playerVC = [[TSCPlayerViewController alloc] init];
    playerVC.live = flow.info;
    [self.navigationController pushViewController:playerVC animated:YES];
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    TSCNearLiveCell * c = (TSCNearLiveCell *)cell;
//    [c showAnimation];
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datalist.count;
}
//(2)为collectionView 渲染cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //(3)从之前的queue中拿出指定identifier 注册的cell类
    TSCNearLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    // 绑定数据
    TSCFlow *flow =self.datalist[indexPath.row];
    cell.info = flow.info;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSInteger count = self.collectionView.width /kItemWidth;
    CGFloat etraWidth =  (self.collectionView.width - kMargin * (count + 1)) / count;
    
    
    return CGSizeMake(etraWidth, etraWidth + 30);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
-(void) initUI{
    //（1）给collectionView注册nib，将cell类放到一个queue里面，并且绑定一个identifier
    [self.collectionView registerNib:[UINib nibWithNibName:@"TSCNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    //初始化下拉刷新
    TSCRefreshHeader *header = [TSCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    //隐藏状态
    header.stateLabel.hidden = YES;
    
    //马上进入刷新状态
    [header beginRefreshing];
    
    self.collectionView.mj_header = header;

}

-(void) loadData {
//    NSDictionary * data = [NSDictionary dictionaryWithObjectsAndKeys:@"gps_info",@"121.498055%2C31.098701",@"loc_info",@"CN%2C上海市%2C上海市%",@"uid",@"613128153", nil];
    NSDictionary * data = @{@"uid":@"613128153",@"latitude":[TSCLocationManager sharedManager].lat,@"longitude":[TSCLocationManager sharedManager].lon};
    [TSCLiveHandler executeGetNearFlowTaskWithData:data Success:^(id obj) {
        self.datalist = obj;
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failed:^(id obj) {
        NSLog(@"%@",obj);
        [self.collectionView.mj_header endRefreshing];
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
