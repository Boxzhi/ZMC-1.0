//
//  DiscountModel.m
//  WashApp
//
//  Created by Daniel on 15/1/19.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import "DiscountModel.h"

@implementation DiscountModel


@end
@implementation DiscountResult

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DiscountData class]};
}

@end


@implementation DiscountData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"coupon_id" : @"id",
             };
}
@end


