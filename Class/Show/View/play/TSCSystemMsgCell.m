//
//  TSCSystemMsgCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2018/1/7.
//  Copyright © 2018年 shawnTang. All rights reserved.
//

#import "TSCSystemMsgCell.h"
@interface TSCSystemMsgCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewTrailing;
@property (weak, nonatomic) IBOutlet UILabel *content;
@end
@implementation TSCSystemMsgCell
-(void)setModel:(TSCChatModel *)model{
    _model = model;
    self.content.text = model.context;
    CGFloat contentWidth = [self.content.text boundingRectWithSize:CGSizeMake(model.tableWidth.floatValue -10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
    if(contentWidth < model.tableWidth.floatValue -15){
        self.backViewTrailing.constant = model.tableWidth.floatValue -15- contentWidth ;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
