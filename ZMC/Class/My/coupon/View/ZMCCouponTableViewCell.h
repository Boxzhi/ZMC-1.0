//
//  ZMCCouponTableViewCell.h
//  ZMC
//
//  Created by Will on 16/5/9.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountModel.h"
@class ZMCCouponItem;
@interface ZMCCouponTableViewCell : UITableViewCell


@property (nonatomic, strong) ZMCCouponItem *item;

- (void)setZMCCouponItem:(DiscountData *)data;

@end
