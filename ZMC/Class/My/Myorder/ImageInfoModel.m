//
//  ImageInfoModel.m
//  YiHaiFarm
//
//  Created by Naive on 16/3/7.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ImageInfoModel.h"

@implementation ImageInfoModel


+ (NSDictionary *)objectClassInArray{
    return @{@"result" : [ImageInfoResult class]};
}
@end
@implementation ImageInfoResult
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"picId" : @"id",
             };
}
@end


