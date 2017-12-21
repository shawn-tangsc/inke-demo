//
//  TSCMainViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/22.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCMainViewController.h"
#import "TSCMainTopView.h"

@interface TSCMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic , strong) NSArray * datalist;

@property (nonatomic, strong) TSCMainTopView* topView;

@end

@implementation TSCMainViewController

-(TSCMainTopView *)topView {
    if(!_topView){
        _topView = [[TSCMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.datalist];
        //YYKitMacro 
        @weakify(self);
        _topView.block = ^(NSInteger tag) {
            @strongify(self);
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];
        };
    }
    return _topView;
}

-(NSArray *)datalist{
    if(!_datalist){
        
        _datalist = @[@"关注",@"热门",@"附近"];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void) initUI {
    //添加左右按钮
    [self setupNav];
    //添加子视图控制器
    [self setupChildViewControllers];

}

- (void) setupNav {

    self.navigationItem.titleView = self.topView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void) setupChildViewControllers {
    NSArray * vcNames = @[@"TSCFocusViewController",@"TSCHotViewControllerNew",@"TSCNearViewController"];
    for (NSInteger i = 0; i<vcNames.count; i++) {
        NSString * vcName = vcNames[i];
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.datalist[i];
        //在执行这句话的时候是不会执行改vc的viewdidload的
        [self addChildViewController:vc];
    }
    //将子控制器的view加到mainVC的scrollview上
    //设置scrollview的contentsize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.datalist.count, 0);
    //默认先展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    //进入主控制器加载第一个页面
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

//动画结束调用代理
//这里非常的麻烦，要抽时间搞懂！！
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offset = scrollView.contentOffset.x;
    //获取索引值
    NSInteger idx = offset / width;
    //索引值联动topView
    [self.topView scrolling:idx];
    //根据索引值返回视图引用
    UIViewController * vc = self.childViewControllers[idx];
    //可以用isViewLoaded方法判断一个UIViewController的view是否已经被加载
    if([vc isViewLoaded]){
        return;
    }
    //设置子控制器的view大小
    //在这里有个初始化的时候自动约束的问题，在刚刚初始化的时候，他会去默认匹配设置375作为自己的宽度，并且会加上一个差值来匹配各个不同的屏幕，这个时候设置vc.view.frame他以为自己还是375，适配plus的时候，他会加上39补足到414，但是这个时候你传值给她414,他还是会加上这个值，从而变成了453，所以在屏幕自适应的时候一定要考虑ios的初始化frame的因素
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    //将子控制器的view加入scrollview上
    [scrollView addSubview:vc.view];
}


//减速结束时调用加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}      // called when scroll view grinds to a halt

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
