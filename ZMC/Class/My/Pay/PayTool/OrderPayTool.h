//
//  OrderPayTool.h
//  ZMC
//
//  Created by MindminiMac on 16/6/7.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderSingleItem.h"

@interface OrderPayTool : NSObject

/**
 *  支付宝支付
 *
 *  @param item    订单模型
 *  @param respond 回调block
 */
+ (void) AlipayMethodWith:(OrderSingleItem *)item backBlock:(void(^)(NSDictionary *resultDic))respond;


/**
 *  微信支付
 */
+ (NSString *)jumpToBizPay;


@end
