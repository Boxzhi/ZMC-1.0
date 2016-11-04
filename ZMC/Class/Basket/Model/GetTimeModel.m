//
//  GetTimeModel.m
//  YiHaiFarm
//
//  Created by Naive on 16/1/11.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "GetTimeModel.h"

@implementation GetTimeModel

@end
@implementation GetTimeResult

+ (NSDictionary *)objectClassInArray{
    return @{@"date" : [GetTimeDate class]};
}

@end


@implementation GetTimeDate

+ (NSDictionary *)objectClassInArray{
    return @{@"sections" : [GetTimeSections class]};
}

@end


@implementation GetTimeSections

@end


