//
//  TSCMainTopView.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface TSCMainTopView : UIView

@property (nonatomic,strong) MainTopBlock block;

- (void) scrolling:(NSInteger)tag;
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

@end
