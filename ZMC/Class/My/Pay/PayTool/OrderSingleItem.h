//
//  OrderSingleItem.h
//  ZMC
//
//  Created by MindminiMac on 16/6/7.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderSingleItem : NSObject

@property (nonatomic, strong) NSString *onlineId;
/**
 *  订单编号
 */
@property (nonatomic, strong) NSString *orderId;
/**
 *  订单流水号
 */
@property (nonatomic, strong) NSString *orderSn;
/**
 *  支付方式
 */
@property (nonatomic, strong) NSString *payWayId;
/**
 *  订单金额
 */
@property (nonatomic, strong) NSString *totalPrice;
/**
 *  折扣后需要支付的价格
 */
@property (nonatomic, strong) NSString *payPrice;

@end
