//
//  HistoryMerchantModel.m
//  ZMC
//
//  Created by Naive on 16/5/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "HistoryMerchantModel.h"

@implementation HistoryMerchantModel

@end

@implementation HistoryMerchantResult

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HistoryMerchantData class]};
}

@end

@implementation HistoryMerchantData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"data_id" : @"id"
             };
}
@end