//
//  ZMCBalanceItem.h
//  ZMC
//
//  Created by Will on 16/5/26.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCBalanceItem : NSObject

// 描述
@property (nonatomic, strong) NSString *description_;
// 金额
@property (nonatomic, strong) NSString *money;
// 历史金额
@property (nonatomic, strong) NSNumber *history_balance;
// 时间
@property (nonatomic, strong) NSString *create_time;
// 来源
@property (nonatomic, strong) NSNumber *source;
// 订单编号
@property (nonatomic, strong) NSString *order_sn;

@end
