//
//  BaseRequestParamsModel.m
//  ThailandGo
//
//  Created by Daniel on 15/9/28.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "BaseRequestParamsModel.h"

@implementation BaseRequestParamsModel

+ (NSMutableDictionary *)baseGetInfoFacory:(NSMutableDictionary *)params{
    
    
    
    return [self Des:[self setPostTotalParams:params]];
    
}

/**
 *  设置公用部分参数
 *
 *  @param parameters 原始params
 *
 *  @return 设置公共部分后的参数
 */
+ (NSMutableDictionary *)setPostTotalParams:(id)parameters{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:parameters forKey:@"param"];
    
//    [params setValue:@"ios" forKey:@"platformType"];
//    [params setObject:@"1.0" forKey:@"appVersion"];
//    [params setObject:@"iphone" forKey:@"phoneModel"];
    
    return parameters;
}

/**
 *  加密参数
 *
 *  @param dic <#dic description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableDictionary *)Des:(NSMutableDictionary *)dic{
    
    
    return dic;
    
}

@end
