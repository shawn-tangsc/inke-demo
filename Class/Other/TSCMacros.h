//
//  TSCMacros.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/22.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#ifndef TSCMacros_h
#define TSCMacros_h
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LL_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define RGB(x,y,z)    [UIColor colorWithRed:(x/255.0) green:(y/255.0) blue:(z/255.0) alpha:1]
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define LRRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif /* TSCMacros_h */
