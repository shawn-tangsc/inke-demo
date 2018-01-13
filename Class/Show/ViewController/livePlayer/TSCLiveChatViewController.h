//
//  TSCLiveChatViewController.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/28.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCBaseViewController.h"
#import "TSCLive.h"
#import "TSCBulletManager.h"
@interface TSCLiveChatViewController : TSCBaseViewController

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (nonatomic,strong) TSCLive * live;
@property (nonatomic, strong) SocketIOClient *client;
@property (nonatomic,retain) TSCBulletManager *bulletManager;

-(void) closeGiftView;
@end
