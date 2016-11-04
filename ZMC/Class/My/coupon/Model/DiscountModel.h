//
//  DiscountModel.h
//  WashApp
//
//  Created by Daniel on 15/1/19.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DiscountResult,DiscountData;
@interface DiscountModel : NSObject



@property (nonatomic, strong) DiscountResult *result;

@property (nonatomic, copy) NSString *err_code;

@property (nonatomic, copy) NSString *err_msg;



@end
@interface DiscountResult : NSObject

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray<DiscountData *> *data;

@property (nonatomic, assign) NSInteger total_pages;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page_size;

@end

@interface DiscountData : NSObject

@property (nonatomic, assign) float denomination;

@property (nonatomic, assign) NSInteger coupon_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString * expire_time;

@property (nonatomic, copy) NSString *desc;

@end

