//
//  TSCHotViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/5.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHotViewController.h"
#import "TSCLiveHandler.h"
#import "TSCLiveCellTableViewCell.h"
#import "TSCCards.h"
//#import <MediaPlayer/MediaPlayer.h>
#import "TSCPlayerViewController.h"
#import "TSCRefreshHeader.h"
static NSString * identifier = @"TSCLiveCellTableViewCell";
@interface TSCHotViewController ()
@property (nonatomic,strong) NSMutableArray * datalist;
@end

@implementation TSCHotViewController


-(NSMutableArray *) datalist {
    if(!_datalist){
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}
//指定每个分区中有多少行，默认为1
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%lu",(unsigned long)self.datalist.count);
    return self.datalist.count;
}

//绘制cell,使用重用
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //从当前tableview中的队列中获取模版，identifier为模版名字
    TSCLiveCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    NSLog(@"%ld",indexPath.row);
    TSCCards *cards =self.datalist[indexPath.row];
    TSCData *data = cards.data;
    cell.live =data.liveInfo;
    return cell;
}
//行高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70 + SCREEN_WIDTH;
}

/**
 实现uitableview中的条目选中事件，选中Cell响应事件

 @param tableView tableView description
 @param indexPath indexPath description
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    TSCCards *cards =self.datalist[indexPath.row];
    TSCData *data = cards.data;
    TSCLive * live = data.liveInfo;
    
    TSCPlayerViewController * playerVC = [[TSCPlayerViewController alloc] init];
    playerVC.live = live;
    [self.navigationController pushViewController:playerVC animated:YES];
    
    /* 自带的播放器 播放不了直播内容
    MPMoviePlayerViewController * movieVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:live.streamAddr]];
    [self presentViewController:movieVC animated:YES completion:nil];
     */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    [self initUI];
    //原生下拉刷新
//    [self setupRefresh];
}

-(void)initUI {
    //注册模版cell到一个队列，名字就是identifier
    [self.tableView registerNib:[UINib nibWithNibName:@"TSCLiveCellTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    //初始化下拉刷新
    TSCRefreshHeader *header = [TSCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    //隐藏状态
    header.stateLabel.hidden = YES;
    
    //马上进入刷新状态
    [header beginRefreshing];
    
    self.tableView.mj_header = header;
}
//原生下拉刷新
//-(void)setupRefresh{
//    UIRefreshControl *control = [[UIRefreshControl alloc]init];
//    control.tintColor = [UIColor grayColor];
//    control.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
//    [control addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
//    self.refreshControl = control;
//    [control beginRefreshing];
//    [self loadData:control];
//}
//原生下拉刷新需要传control
//-(void)loadData:(UIRefreshControl *)control {
//    NSLog(@"下拉刷新");
//    [TSCLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
//        [self.datalist removeAllObjects];
//        [self.datalist addObjectsFromArray:obj];
//        [self.tableView reloadData];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//             [control endRefreshing];
//        });
//
//    } failed:^(id obj) {
//        NSLog(@"%@",obj);
//        [control endRefreshing];
//    }];
//}
-(void)loadData {
    NSLog(@"下拉刷新");
    [TSCLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        NSArray *lives = [TSCCards mj_objectArrayWithKeyValuesArray:obj[@"cards"]];
        [self.datalist removeAllObjects];
        [self.datalist addObjectsFromArray:lives];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failed:^(id obj) {
        NSLog(@"%@",obj);
        [self.tableView.mj_header endRefreshing];
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
