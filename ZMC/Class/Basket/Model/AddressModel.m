//
//  AddressModel.m
//  ZMC
//
//  Created by Naive on 16/5/25.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

@end

@implementation AddressResult
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"address_id" : @"id",
             };
}
@end