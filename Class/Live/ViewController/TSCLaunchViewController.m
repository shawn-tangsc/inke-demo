//
//  TSCLaunchViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/5.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCLaunchViewController.h"

@interface TSCLaunchViewController ()

@end

@implementation TSCLaunchViewController
- (IBAction)closeLaunch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
