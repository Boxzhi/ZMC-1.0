//
//  ZMCMyHeaderView.m
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyHeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import "ZMCMyHeaderItem.h"

@interface ZMCMyHeaderView()


@end

@implementation ZMCMyHeaderView



-(void)awakeFromNib{
    
    self.myImageView.layer.cornerRadius = 39;
    self.myImageView.layer.masksToBounds = YES;
    
    CALayer *layer = [_myImageView layer];
    layer.borderColor = RGB(147, 218, 164).CGColor;
    layer.borderWidth = 3.0f;
    
    
    
}




- (void)setItem:(ZMCMyHeaderItem *)item{
    _item = item;
    
    // 头像
    [self.myImageView zmc_setHeader:item.avatar_url];
    
//     昵称
//    if ([item.nick_name isEqualToString:@"用户"]) {
//        self.nameLabel.text = @"怎么吃";
//    }else{
    self.nameLabel.text = item.nick_name;
//    }
    
//     会员等级
    NSString *vip = item.member_level;
    switch ([vip integerValue]) {
        case 1:
            self.memberImage.image = [UIImage imageNamed:@"medal_tong"];
            break;
        case 2:
            self.memberImage.image = [UIImage imageNamed:@"medal_yin"];
            break;
        case 3:
            self.memberImage.image = [UIImage imageNamed:@"medal_jin"];
            break;
        default: self.memberImage.hidden = YES;
            break;
    }
    

    
//     个性签名
    self.autographLabel.text = item.signature;
    
    
    if (!TOKEN) {
        self.balanceLabel.text = @"¥ 0";
        self.frozenLabel.text = @"¥ 0.00";
        // 积分
        self.pointsLabel.text = @"0";
    }else{
        
        // 余额
        self.balanceLabel.text = [NSString stringWithFormat:@"¥ %.2f", [item.balance floatValue]];
        
        // 冻结金额
        self.frozenLabel.text = [NSString stringWithFormat:@"¥ %.2f", [item.frozen_funds floatValue]];
        
        // 积分
        self.pointsLabel.text = item.points;
    }
    
    
    
    
    
}

+ (instancetype)myHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    
}
@end
