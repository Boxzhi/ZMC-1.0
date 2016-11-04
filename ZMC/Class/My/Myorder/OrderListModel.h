//
//  OrderListModel.h
//  ZMC
//
//  Created by Naive on 16/5/31.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderListResult,OrderData,OrderListOrderBizs,OrderListOrderCook,OrderListOrderGoods;
@interface OrderListModel : NSObject

@property (nonatomic, strong) OrderListResult *result;

@property (nonatomic, copy) NSString *err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface OrderListResult : NSObject

@property (nonatomic, assign) NSInteger page_size;

@property (nonatomic, assign) NSInteger total_pages;

@property (nonatomic, strong) NSArray<OrderData *> *data;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page;

@end

@interface OrderData : NSObject

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, strong) NSArray<OrderListOrderBizs *> *order_bizs;

@property (nonatomic, strong) OrderListOrderCook *order_cook;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, assign) NSInteger order_status;

@property (nonatomic, copy) NSString *order_status_name;

@property (nonatomic, assign) float paid_money;

@end

@interface OrderListOrderBizs : NSObject

@property (nonatomic, copy) NSString *biz_order_sn;

@property (nonatomic, strong) NSArray<OrderListOrderGoods *> *goods;

@property (nonatomic, assign) NSInteger merchant_id;

@property (nonatomic, copy) NSString *merchant_name;

@property (nonatomic, assign) NSInteger status;

@end

@interface OrderListOrderCook : NSObject

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, assign) NSInteger has_comment;

@property (nonatomic, assign) NSInteger cook_id;

@property (nonatomic, copy) NSString *cook_name;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger status;

@end

@interface OrderListOrderGoods : NSObject

@property (nonatomic, assign) float actual_price;

@property (nonatomic, assign) float actual_weight;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, assign) NSInteger has_comment;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, copy) NSString *unit_name;

@property (nonatomic, assign) NSInteger weight;

@end