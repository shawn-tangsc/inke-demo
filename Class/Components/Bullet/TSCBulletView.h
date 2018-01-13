//
//  TSCBulletView.h
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/9.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MoveStatus) {
    Start,
    Enter,
    End
};
@interface TSCBulletView : UIView

@property (nonatomic, assign) int trajectory;//弹道
@property (nonatomic, copy) void(^moveStatusBlock)(MoveStatus status);//弹幕状态的回调

-(instancetype) initWithContent:(NSString *)content;

-(void) startAnimation;

-(void) stopAnimation;
@end
