//
//  ShoppongCartsModel.h
//  ZMC
//
//  Created by Naive on 16/5/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShoppongCartsResult,ShoppongCartsCooks,ShoppongCartsMerchants,ShoppongCartsGooods;
@interface ShoppongCartsModel : NSObject

@property (nonatomic, strong) ShoppongCartsResult *result;

@property (nonatomic, copy) NSString *err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface ShoppongCartsResult : NSObject

@property (nonatomic, strong) NSArray<ShoppongCartsCooks *> *cooks;

@property (nonatomic, strong) NSArray<ShoppongCartsMerchants *> *merchants;

@property (nonatomic, assign) float total_price;

@property (nonatomic, assign) NSInteger total;

@end

@interface ShoppongCartsCooks : NSObject

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) NSInteger cooks_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger quantity;

//@property (nonatomic, assign) NSInteger start_time;

@property (nonatomic, copy) NSString *start_time;

@end

@interface ShoppongCartsMerchants : NSObject

@property (nonatomic, strong) NSArray<ShoppongCartsGooods *> *goods;

@property (nonatomic, assign) NSInteger merchants_id;

@property (nonatomic, copy) NSString *name;

@end

@interface ShoppongCartsGooods : NSObject

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) float original_price;

@property (nonatomic, assign) NSInteger original_unit;

@property (nonatomic, copy) NSString *original_unit_name;

@property (nonatomic, assign) NSInteger nature;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger stock;

@property (nonatomic, assign) float sum_price;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, copy) NSString *unit_name;

@end
