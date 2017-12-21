//
//  TSCBaseNavViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/22.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCBaseNavViewController.h"

@interface TSCBaseNavViewController ()

@end

@implementation TSCBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = RGB(0, 216, 201);
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 当被push进来的时候

 @param viewController viewController description
 
 @param animated animated description
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count){
        viewController.hidesBottomBarWhenPushed =YES;
    }
    [super pushViewController:viewController animated:animated];
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
