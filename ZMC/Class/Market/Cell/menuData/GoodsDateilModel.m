//
//  GoodsDateilModel.m
//  ZMC
//
//  Created by Naive on 16/5/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "GoodsDateilModel.h"


@implementation GoodsDateilModel

@end

@implementation GoodsDetailResult
+ (NSDictionary *)objectClassInArray{
    return @{@"supported_services" : [Supported_services class],@"activity_label" : [Activity_label class],@"nutrition_collocation_lists" : [NutritionCollocationLists class],@"pic_list" : [Pic_list class]};
}



+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"good_id" : @"id",
             @"good_description" : @"description",
             };
}
@end


@implementation Activity_label
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"activity_id" : @"id"
             };
}
@end

@implementation Supported_services
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"supported_id" : @"id"
             };
}
@end

@implementation NutritionCollocationLists

@end

@implementation Pic_list

@end

@implementation Merchant
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"merchant_id" : @"id"
             };
}

@end
