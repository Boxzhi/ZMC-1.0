//
//  ZMCCouponItem.h
//  ZMC
//
//  Created by Will on 16/5/23.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCCouponItem : NSObject

// 优惠券面额
@property (nonatomic, strong) NSNumber *denomination;
// 优惠券描述
@property (nonatomic, strong) NSString *desc;
// 过期时间
@property (nonatomic, strong) NSString *expire_time;
// 优惠券编号
@property (nonatomic, strong) NSNumber *itemid;
// 优惠券名称
@property (nonatomic, strong) NSString *title;

@end
