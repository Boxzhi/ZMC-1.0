//
//  ZMCAddressManger.h
//  ZMC
//
//  Created by Will on 16/5/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCAddressManger : NSObject

// 查询收货地址
+ (void)getressMgResult:(void(^)(NSDictionary *result))result;

// 添加收货地址
+ (void)addaddressConsignee:(NSString *)consignee mobile:(NSString *)mobile province_id:(NSNumber *)province_id city_id:(NSNumber *)city_id district_id:(NSNumber *)district_id street_address:(NSString *)street_address is_default:(NSString *)is_default result:(void(^)(NSDictionary *result))result;

// 编辑收货地址
+ (void)addaddressConsignee:(NSString *)consignee mobile:(NSString *)mobile province_id:(NSNumber *)province_id city_id:(NSNumber *)city_id district_id:(NSNumber *)district_id street_address:(NSString *)street_address is_default:(NSString *)is_default SerialId:(NSNumber *)SerialId result:(void(^)(NSDictionary *result))result;

// 删除收货地址
+ (void)deldteAddressId:(NSNumber *)Id result:(void(^)(NSDictionary *result))result;

@end
