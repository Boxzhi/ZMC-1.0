//
//  ActivityListModel.m
//  ZMC
//
//  Created by Naive on 16/6/8.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ActivityListModel.h"

@implementation ActivityListModel

@end

@implementation ActivityListResult

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [ActivityListData class]};
}


@end

@implementation ActivityListData

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"data_id" : @"id",
             };
}

@end
