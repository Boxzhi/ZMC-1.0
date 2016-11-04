//
//  ShoppongCartsModel.m
//  ZMC
//
//  Created by Naive on 16/5/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ShoppongCartsModel.h"

@implementation ShoppongCartsModel

@end

@implementation ShoppongCartsResult

+ (NSDictionary *)objectClassInArray{
    return @{@"cooks" : [ShoppongCartsCooks class],@"merchants" : [ShoppongCartsMerchants class]};
}

@end

@implementation ShoppongCartsCooks

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"cooks_id" : @"id",
             };
}

@end

@implementation ShoppongCartsMerchants

+ (NSDictionary *)objectClassInArray{
    return @{@"goods" : [ShoppongCartsGooods class]};
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"merchants_id" : @"id",
             };
}

@end

@implementation ShoppongCartsGooods

@end
