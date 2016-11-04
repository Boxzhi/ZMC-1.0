//
//  MerchantDetailModel.h
//  ZMC
//
//  Created by Naive on 16/6/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MerchantDetailResult,MerchantDetailNewLists,MerchantDetailSpecialLists;
@interface MerchantDetailModel : NSObject

@property (nonatomic, strong) MerchantDetailResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface MerchantDetailResult : NSObject

@property (nonatomic, copy) NSString *boothNo;

@property (nonatomic, assign) NSInteger collection_count;

@property (nonatomic, assign) NSInteger merchant_id;

@property (nonatomic, copy) NSString *market_name;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<MerchantDetailNewLists *> *n_lists;

@property (nonatomic, strong) NSArray<MerchantDetailSpecialLists *> *special_lists;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, assign) NSInteger sale;

@property (nonatomic, assign) NSInteger sales_volume;

@property (nonatomic, assign) int is_fav;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger kind_count;


@end

@interface MerchantDetailNewLists : NSObject

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, copy) NSString *unit_name;

@end

@interface MerchantDetailSpecialLists : NSObject

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, copy) NSString *unit_name;

@end