//
//  MerchantDetailModel.m
//  ZMC
//
//  Created by Naive on 16/6/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "MerchantDetailModel.h"

@implementation MerchantDetailModel

@end

@implementation MerchantDetailResult

+ (NSDictionary *)objectClassInArray{
    return @{@"n_lists" : [MerchantDetailNewLists class],@"special_lists" : [MerchantDetailSpecialLists class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"n_lists" : @"new_lists",
             @"merchant_id" : @"id"
             };
}

@end

@implementation MerchantDetailNewLists

@end

@implementation MerchantDetailSpecialLists

@end
