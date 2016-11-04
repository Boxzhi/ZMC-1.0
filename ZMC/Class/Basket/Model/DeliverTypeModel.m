//
//  DeliverTypeModel.m
//  YiHaiFarm
//
//  Created by Naive on 16/1/6.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "DeliverTypeModel.h"

@implementation DeliverTypeModel

@end
@implementation DeliverTypeResult

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DeliverTypeList class]};
}

@end


@implementation DeliverTypeList
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"data_id" : @"id",
             };
}
@end


