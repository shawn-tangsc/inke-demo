//
//  TSCMainTopView.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/11/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCMainTopView.h"

@interface TSCMainTopView()

@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) NSMutableArray * buttons;

@end

@implementation TSCMainTopView

-(NSMutableArray *) buttons{
    if(!_buttons){
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat btnWidth = self.width / titles.count;
        CGFloat btnHeight = self.height;
        
        
        for (NSInteger i = 0; i<titles.count; i++) {
            UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString * vcName = titles[i];
            //设置按钮文字
            [titleBtn setTitle:vcName forState:UIControlStateNormal];
            //按钮颜色
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //设置字体
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            
//            titleBtn.backgroundColor = [UIColor grayColor];
            
            titleBtn.tag = i;
            
            titleBtn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
            //设置监听
            [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:titleBtn];
            [self.buttons addObject:titleBtn];
            if(i == 1 ){
                CGFloat h = 2;
                CGFloat y = 38;
                [titleBtn.titleLabel sizeToFit];
                self.lineView = [[UIView alloc] init];
                self.lineView.backgroundColor = [UIColor whiteColor];
                self.lineView.height = h;
                self.lineView.width = titleBtn.titleLabel.width;
                self.lineView.top = y;
                self.lineView.centerX = titleBtn.centerX;
                [self addSubview:self.lineView];
            }
        }
    }
    return self;
}


-(void) titleClick:(UIButton *)button{
    
    self.block(button.tag);
    
    [self scrolling:button.tag];
    
}

//mainVC调用
- (void) scrolling:(NSInteger)tag{
    
    UIButton * button = self.buttons[tag];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.centerX = button.centerX;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
