//
//  TSCMainTopView.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
   1. typedef类型定义https://www.jianshu.com/p/b932b339da8d
    作用：给类型起别名（给已知的类型起别名）。常用于简化复杂类型，变量类型意义化等。
 
     typedef double NSTimeInterval;  //给double取别名为NSTimeInterval（变量类型意义化）
     typedef NSTimeInterval MyTime;  //给NSTimeInterval取别名为MyTime
     typedef char * MyString;  //给char *取别名为MyString
 
     typedef struct Person
     {
     char *name
     }MyPerson;  //给Person结构体取别名为MyPerson。使用:MyPerson p = {"jack"};
 
     typedef enum Gender
     {
     Man,
     Woman
     }MyGender;  //给Gender枚举取别名为MyGender。使用:MyGender g = Man;
 
     typedef void(^MyBlock) (int a,int b);  //给block取别名MyBlock
     typedef int(*MyFunction) (int a,int b);  //给指向函数的指针取别名MyFunction
 
 */
// block声明语法：返回值(^block名字)(入参类型 入参名称);
typedef void(^MainTopBlock)(NSInteger tag);

@interface TSCMainTopView : UIView
//设置一个回调block
@property (nonatomic,strong) MainTopBlock block;

- (void) scrolling:(NSInteger)tag;
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

@end
