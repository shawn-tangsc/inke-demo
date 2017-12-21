//
//  TSCBannerImageCell.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/17.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCBannerImageCell.h"
@interface TSCBannerImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation TSCBannerImageCell
-(void)setImageUrl:(NSString *)imageUrl{
    [self.image downloadImage:imageUrl placeholder:@"default_room"];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
