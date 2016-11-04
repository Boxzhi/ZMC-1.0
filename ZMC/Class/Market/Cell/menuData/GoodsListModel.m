//
//  GoodsListModel.m
//  YiHaiFarm
//
//  Created by Naive on 15/12/21.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel

@end


@implementation GoodsListResult

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [GoodsListData class]};
}

@end


@implementation GoodsListData

+ (NSDictionary *)objectClassInArray{
    return @{@"activity_label" : [GoodsListActivity_Label class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"goods_id" : @"id"
             };
}
@end


@implementation GoodsListActivity_Label
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"activity_id" : @"id"
             };
}
@end


