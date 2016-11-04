//
//  ZMCCouponTableViewCell.m
//  ZMC
//
//  Created by Will on 16/5/9.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCouponTableViewCell.h"
#import "ZMCCouponItem.h"


@interface ZMCCouponTableViewCell()
// 优惠券面额
@property (weak, nonatomic) IBOutlet UILabel *demtLabel;

// 优惠券名称
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

// 过期时间
@property (weak, nonatomic) IBOutlet UILabel *extimeLabel;

// 优惠券描述
@property (weak, nonatomic) IBOutlet UILabel *descLabel;



@end


@implementation ZMCCouponTableViewCell

//- (void)setZMCCouponItem:(DiscountData *)data {
//    
//    self.demtLabel.text = [NSString stringWithFormat:@"%.f", data.denomination];
//    self.descLabel.text = data.desc;
//    self.titleLabel.text = data.title;
//    self.extimeLabel.text = data.expire_time;
//}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(ZMCCouponItem *)item{
    _item = item;
    
    self.demtLabel.text = [NSString stringWithFormat:@"%@", item.denomination];
    self.descLabel.text = item.desc;
    self.titleLabel.text = item.title;
    self.extimeLabel.text = item.expire_time;
    ZMCLog(@"---%@", self.extimeLabel.text);
 
}



@end
