//
//  TSCTabBarViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/22.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCTabBarViewController.h"

#import "TSCBaseNavViewController.h"
#import "TSCLaunchViewController.h"


@interface TSCTabBarViewController ()<TSCTabbarDelegate>

@property (nonatomic,strong)TSCTabBar * tscTabbar;

@end

@implementation TSCTabBarViewController

-(TSCTabBar *)tscTabbar{
    if(!_tscTabbar){
        _tscTabbar = [[TSCTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _tscTabbar.delegate = self;
    }
    return _tscTabbar;
}

-(void)tabbar:(TSCTabBar *)tabbar clickButton:(TSCItemType)idx{
    if(idx != TSCItemTypeLaunch){
        self.selectedIndex = idx - TSCItemTypeLive;
        return;
    }
    TSCLaunchViewController * launchVC = [[TSCLaunchViewController alloc] init];
    [self presentViewController:launchVC animated:YES completion:nil];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self configViewController];
    
    [self.tabBar addSubview:self.tscTabbar];
    //解决tabbar阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];

}

-(void) configViewController {
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"TSCMainViewController",@"TSCMeViewController"]];
    for (NSInteger i =0; i<array.count; i++) {
        NSString * vcName = array[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        TSCBaseNavViewController * nav = [[TSCBaseNavViewController alloc]initWithRootViewController:vc];
        [array replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = array;
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
