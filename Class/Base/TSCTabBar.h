//
//  TSCTabBar.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/22.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TSCItemType) {
    TSCItemTypeLaunch = 10,//启动直播
    TSCItemTypeLive = 100,//展示直播
    TSCItemTypeMe,//我的
};

@class TSCTabBar;

typedef void(^TabBlock)(TSCTabBar * tabbar,TSCItemType idx);
//这里有个比较有意思的http://blog.csdn.net/mccand1234/article/details/52278616
@protocol TSCTabbarDelegate <NSObject>

- (void) tabbar:(TSCTabBar *)tabbar clickButton:(TSCItemType) idx;

@end

@interface TSCTabBar : UIView

@property (nonatomic,weak) id<TSCTabbarDelegate> delegate;

@property (nonatomic,copy) TabBlock block;

- (UIButton *) camearButton;
@end
