//
//  GoodsCategoryModel.m
//  YiHaiFarm
//
//  Created by Naive on 15/12/21.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import "GoodsCategoryModel.h"

@implementation GoodsCategoryModel



+ (NSDictionary *)objectClassInArray{
    return @{@"result" : [GoodsCategoryResult class]};
}
@end


@implementation GoodsCategoryResult

+ (NSDictionary *)objectClassInArray{
    return @{@"childs" : [GoodsCategoryChilds class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"list_id" : @"id",
             };
}

@end


@implementation GoodsCategoryChilds
+ (NSDictionary *)objectClassInArray{
    return @{@"childs" : [GoodsCategoryChildsChilds class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"child_id" : @"id",
             };
}

@end

@implementation GoodsCategoryChildsChilds
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"child_id" : @"id",
             };
}

@end
