//
//  OrderDetailModel.h
//  ZMC
//
//  Created by Naive on 16/6/1.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderDetailResult,OrderDetailOrderBizs,OrderDetailGoods,OrderDetailOrderLogs,OrderDetailOrderCook;
@interface OrderDetailModel : NSObject

@property (nonatomic, strong) OrderDetailResult *result;

@property (nonatomic, copy) NSString *err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface OrderDetailResult : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *district_name;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *delivery_time;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) NSArray<OrderDetailOrderBizs *> *order_bizs;

@property (nonatomic, strong) NSArray<OrderDetailOrderLogs *> *order_logs;

@property (nonatomic, strong) OrderDetailOrderCook *order_cook;

@property (nonatomic, copy) NSString *order_sn;

@property (nonatomic, copy) NSString *page;

@property (nonatomic, copy) NSString *page_size;

@property (nonatomic, copy) NSString *province_name;

@property (nonatomic, copy) NSString *total;

@property (nonatomic, copy) NSString *total_pages;

@property (nonatomic, assign) NSInteger order_status;

@property (nonatomic, copy) NSString *order_status_name;

@property (nonatomic, copy) NSString *total_price;

@property (nonatomic, copy) NSString *paid_money;

@end

@interface OrderDetailOrderBizs : NSObject

@property (nonatomic, copy) NSString *biz_order_sn;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, strong) NSArray<OrderDetailGoods *> *goods;

@property (nonatomic, assign) NSInteger merchant_id;

@property (nonatomic, copy) NSString *merchant_name;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) float total_price;

@end

@interface OrderDetailGoods : NSObject

@property (nonatomic, assign) float actual_price;

@property (nonatomic, assign) float actual_weight;

@property (nonatomic, assign) NSInteger has_comment;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *unit_name;

@end

@interface OrderDetailOrderLogs : NSObject

@property (nonatomic, copy) NSString *create_date;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *status_name;

@end

@interface OrderDetailOrderCook : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, assign) NSInteger cook_id;

@property (nonatomic, copy) NSString *cook_name;

@property (nonatomic, assign) NSInteger order_id;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *unit;

@end