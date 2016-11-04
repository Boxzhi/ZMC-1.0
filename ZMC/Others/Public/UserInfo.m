//
//  UserInfo.m
//  YHPromotion
//
//  Created by Naive on 16/3/30.
//  Copyright © 2016年 Naive. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


+(UserInfo *) share
{
    static dispatch_once_t pred;
    static UserInfo *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[UserInfo alloc] init];
    });
    return shared;
}

+ (BOOL)isLogin{
    
    if ([@"1" isEqualToString:[USER_DEFAULT objectForKey:ISLOGIN]]) {
        
        return  YES;
        
    }else{
        
        return  NO;
        
    }
    
    
}

+ (void)loginOut{
    
    [USER_DEFAULT setObject:@"0" forKey:ISLOGIN];
    
//    
//    [TotalAccessTokenTool shared].tokenModel = nil;
//    
//    [USER_DEFAULT setObject:[TotalAccessTokenTool shared].tokenModel.refresh_token forKey:@"access_token"];
//    [USER_DEFAULT setObject:[TotalAccessTokenTool shared].tokenModel.access_token forKey:@"refresh_token"];
    
    [USER_DEFAULT removeObjectForKey:@"access_token"];
    [USER_DEFAULT removeObjectForKey:@"refresh_token"];
    [USER_DEFAULT removeObjectForKey:@"expire_time"];
    [USER_DEFAULT removeObjectForKey:@"login_time"];

//    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:QRCODE];
    [USER_DEFAULT synchronize];
}

@end
@implementation UserInfoResult


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"user_id" : @"id",
             };
}

@end
