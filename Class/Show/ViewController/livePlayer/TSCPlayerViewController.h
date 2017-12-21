//
//  TSCPlayerViewController.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/26.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCBaseViewController.h"
#import "TSCLive.h"
@interface TSCPlayerViewController : TSCBaseViewController

@property (nonatomic,strong) TSCLive * live;
@property(nonatomic,strong) UIButton * closeBtn;
@end
