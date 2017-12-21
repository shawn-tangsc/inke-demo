//
//  TSCHotGameCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/17.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCHotGameCell.h"
#import "TSCCoverElements.h"
#import "TSCTicker.h"
@interface TSCHotGameCell()
@property (weak, nonatomic) IBOutlet UILabel *onlineUsersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gameImage;

@end
@implementation TSCHotGameCell
-(void)setCard:(TSCHotSpecialCard *)card{
    _card = card;
//    NSString *imagePath =[live.creator.portrait hasPrefix:@"http://"]?live.creator.portrait: [NSString stringWithFormat:@"%@%@",RESOURCE_HOST,live.creator.portrait];
//    [self.userImage downloadImage:imagePath placeholder:@"default_room"];
//    NSArray<> *elements = card.cover.elements[0];
    TSCCoverElements *element =card.cover.elements[0];
//    NSString *imagePath = [card.cover.elements]
    self.onlineUsersLabel.text = element.text;
    TSCTicker *ticker = (TSCTicker *)card.data.ticker[0];
    [self.gameImage downloadImage:ticker.image placeholder:@"default_room"];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
