//
//  UIView+TSCAlert.h
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/2.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TSCAlert)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
- (void)setLabelShadow;
- (void)showAlert:(NSString *)message;
- (void)showAlert:(NSString *)title message:(NSString *)message;
@end
