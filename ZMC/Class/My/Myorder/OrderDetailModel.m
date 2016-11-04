//
//  OrderDetailModel.m
//  ZMC
//
//  Created by Naive on 16/6/1.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

@end

@implementation OrderDetailResult

+ (NSDictionary *)objectClassInArray{
    return @{@"order_bizs" : [OrderDetailOrderBizs class],@"order_logs" : [OrderDetailOrderLogs class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"order_id" : @"id",
             };
}

@end

@implementation OrderDetailOrderBizs

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [OrderDetailGoods class]};
}

@end

@implementation OrderDetailGoods
// @"price" : @"sale_price",
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"goods_id" : @"id",
             };
}

@end

@implementation OrderDetailOrderLogs

@end

@implementation OrderDetailOrderCook

@end
