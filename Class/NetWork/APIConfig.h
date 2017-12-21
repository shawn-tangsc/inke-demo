//
//  APIConfig.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

//服务器地址
#define SERVER_HOST @"http://service.inke.com"

//今天web资源服务器
#define WEBAPI_HOST @"http://webapi.busi.inke.cn"


//热门直播-------cover.style 1或2:直播，6:广告  4:滚动直播 5：游戏 ps:并没有找到3是什么意思
#define API_HotLive @"/api/live/card_recommend"


//附近的人
#define API_Near @"/api/live/near_flow_old"

//资源服务器
#define RESOURCE_HOST @"http://img2.inke.cn/"

//直播页观看人数//start=0&count=20&id=1512271172300544
#define API_Live_Users @"/api/live/users"

//礼物
#define API_Live_Gift @"/api/resource/user_gifts"

//广告页
#define APP_Flash_Screen @"/app/Flash_screen"

@end
