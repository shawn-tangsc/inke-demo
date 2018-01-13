//
//  main.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/21.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


/*
    ios应用程序的入口function https://www.jianshu.com/p/f4b80291ba0f 可以看看ios的堆栈理解
    了解程序的入口http://blog.csdn.net/lvxiangan/article/details/19076911 main方法
    oc基本类型：https://www.jianshu.com/p/987fb6fb49dc
 */
int main(int argc, char * argv[]) {
    
    /*
        没有ARC之前的写法如下：
     
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
     
        int retVal = UIApplicationMain(argc, argv, nil, nil);
     
        [pool release];
        return retVal;
     
        超过autorelease pool作用域范围时，obj会自动调用release方法
        在代码中基本不需要使用@autoreleasepool 因为在app的入口文件中就已经使用过它了。
     */
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
