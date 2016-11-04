//
//  GoodsDateilModel.h
//  ZMC
//
//  Created by Naive on 16/5/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsDetailResult,Supported_services,Activity_label,NutritionCollocationLists,Pic_list,Merchant;
@interface GoodsDateilModel : NSObject


@property (nonatomic, strong) GoodsDetailResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;


@end

@interface GoodsDetailResult : NSObject

@property (nonatomic, strong) NSArray<Activity_label *> *activity_label;

@property (nonatomic, strong) NSArray<NutritionCollocationLists *> *nutrition_collocation_lists;

@property (nonatomic, assign) NSInteger good_id;

//@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, assign) NSInteger nature;

@property (nonatomic, copy) NSNumber *original_price;

@property (nonatomic, assign) NSInteger original_unit;

@property (nonatomic, strong) NSString *original_unit_name;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, copy) NSString *good_description;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger saled_count;

@property (nonatomic, copy) NSString *goods_sn;

@property (nonatomic, copy) NSString *keep_mode_name;

@property (nonatomic,copy) NSString *short_intro;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger is_fav;

@property (nonatomic, copy) NSString *origin;

@property (nonatomic, copy) NSString *detail_pic;

@property (nonatomic, copy) NSString *detail_url;

@property (nonatomic, copy) NSString *unit_name;

@property (nonatomic, copy) NSString *merchant_name;

@property (nonatomic, assign) NSInteger merchant_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<Supported_services *> *supported_services;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger comment_count;

@property (nonatomic, strong) NSArray<Pic_list *> *pic_list;

@property (nonatomic, strong) Merchant *merchant;

@end

@interface Supported_services : NSObject

@property (nonatomic, assign) NSInteger supported_id;

@property (nonatomic, copy) NSString *name;

@end

@interface Activity_label : NSObject

@property (nonatomic, assign) NSInteger activity_id;

@property (nonatomic, copy) NSString *name;

@end

@interface NutritionCollocationLists : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *quantity;

@end

@interface Pic_list : NSObject

@property (nonatomic, copy) NSString *pic;

@end

@interface Merchant : NSObject

@property (nonatomic, copy) NSString *booth_no;

@property (nonatomic, assign) NSInteger merchant_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) NSInteger selling_goods_cnt;

@property (nonatomic, assign) NSInteger sold_orders_cnt;

@end
