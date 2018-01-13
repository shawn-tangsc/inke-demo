//
//  TSCSwitch.h
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/13.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 开关的设计思路:
 *
 * 开关左边为关闭状态,右边为打开状态.
 * 开关的size不可改变.
 * 开关的视图结构:(底部 --> 上层)
 *    1.最底部是本身,承载点击事件.
 *    2.开关打开下的显示视图.
 *    3.开关关闭下的显示视图.
 *    4.开关切换的按钮(小圆).
 * 开关的动画实现思路:
 *    1.小圆使用UIView的spring动画做x坐标的平移.
 *    2.开关打开与关闭下的显示视图使用UIView动画做backgroundColor的渐变.
 * 后续还可改进的地方:
 *    1.可添加一点阴影效果.
 *    2.还可添加一些有趣的动画.
 *    3.xib添加.
 */

@interface TSCSwitch : UIView


//http://blog.csdn.net/zcube/article/details/51657417
//Objective-C 中主要通过NS_DESIGNATED_INITIALIZER宏来实现指定构造器的。这里之所以要用这个宏，往往是想告诉调用者要用这个方法去初始化（构造）类对象。
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic,readonly, assign) BOOL isOn;

/**
 *  当开关关闭时的颜色
 */
@property (nonatomic,strong) UIColor *tintColor;

/**
 *  当开关打开时的颜色
 */
@property (nonatomic,strong) UIColor *onTintColor;

/**
 *  小圈圈的颜色
 */
@property (nonatomic,strong) UIColor *thumbTintColor;

@property (nonatomic,copy) NSString *tumbText;

/**
 *  按钮将要切换时的回调
 */
- (void)switchWillStartSwicth:(void(^)(BOOL isOn)) startBlock;

/**
 *  按钮已完成切换时的回调
 */
- (void)switchDidEndSwitch:(void(^)(BOOL isOn)) endBlock;
@end
