//
//  TSCNearLiveCell.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/2.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSCLive.h"
@interface TSCNearLiveCell : UICollectionViewCell

@property (nonatomic,strong) TSCLive *info;

-(void)showAnimation;
@end
