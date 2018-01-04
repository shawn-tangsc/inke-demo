//
//  TSCChatViewCell.m
//  Test-inke
//  说实话，可能是不会用吧，真tmd不喜欢用xib来布局，肯定是没有masnary布局来得干净
//  Created by 唐嗣成 on 2018/1/2.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import "TSCChatViewCell.h"

@interface TSCChatViewCell()
@property (weak, nonatomic) IBOutlet UILabel *context;
@property (weak, nonatomic) IBOutlet UIButton *userName;
@property (weak, nonatomic) IBOutlet UIView *levelView;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *secondContent;
@property (weak, nonatomic) IBOutlet UIView *backgroudView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundTraillingConstraints;


@end
@implementation TSCChatViewCell

-(void)setModel:(TSCChatModel *)model{
    [self clearData];
    _model = model;
   
    [self.userName setTitle:model.name forState:UIControlStateNormal];
    self.level.text =[NSString stringWithFormat:@"%ld",(long)model.userLevel.integerValue] ;
    if(model.userLevel.integerValue < 17){
        self.levelView.backgroundColor = [UIColor colorWithRed:147.0/225.0 green:202.0/225.0 blue:20.0/225.0 alpha:1];
    }else if (model.userLevel.integerValue<30 && 17<=model.userLevel.integerValue){
        self.levelView.backgroundColor = [UIColor colorWithRed:246.0/225.0 green:141.0/225.0 blue:73.0/225.0 alpha:1];
        
    }else if (model.userLevel.integerValue<70 && 30<=model.userLevel.integerValue){
        self.levelView.backgroundColor = [UIColor colorWithRed:249.0/225.0 green:101.0/225.0 blue:164.0/225.0 alpha:1];
        
    }else if (model.userLevel.integerValue<150 && 70<=model.userLevel.integerValue){
        self.levelView.backgroundColor = [UIColor colorWithRed:60.0/225.0 green:214.0/225.0 blue:215.0/225.0 alpha:1];
        
    }else {
        self.levelView.backgroundColor = [UIColor colorWithRed:124.0/225.0 green:150.0/225.0 blue:245.0/225.0 alpha:1];
    }
    if(model.isMoreLine){
        self.context.text = model.firstContent;
        self.secondContent.text = model.secondContent;
//        self.secondContentWidthConstraints.constant = model.secondContentSize.width;
//        self.secondContentHeightConstraints.constant = model.secondContentSize.height;
//        [self.secondContent layoutIfNeeded];
    }else{
        self.context.text = model.context;
        self.backgroundTraillingConstraints.constant+=model.backgroundTrailling.floatValue-10;
    }
}
- (IBAction)nameClick:(id)sender {
    [self.superview showAlert:@"人物信息还没做"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
  
    // Initialization code
}
-(void) clearData{
     self.backgroundTraillingConstraints.constant = 0;
    self.secondContent.text = @"";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
