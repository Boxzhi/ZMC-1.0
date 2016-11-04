//
//  OrderListModel.m
//  ZMC
//
//  Created by Naive on 16/5/31.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

@end

@implementation OrderListResult

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [OrderData class]};
}

@end

@implementation OrderData

+ (NSDictionary *)objectClassInArray{
    return @{@"order_bizs" : [OrderListOrderBizs class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"order_id" : @"id",
             };
}

@end

@implementation OrderListOrderBizs

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [OrderListOrderGoods class]};
}

@end

@implementation OrderListOrderCook

@end

@implementation OrderListOrderGoods

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"goods_id" : @"id",
             };
}

@end