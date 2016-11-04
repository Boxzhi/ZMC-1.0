//
//  ZMCTokenTool.m
//  ZMC
//
//  Created by Will on 16/5/24.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import "ZMCTokenTool.h"
#import "ZMCTokenResultItem.h"
#import "ZMCLoginViewController.h"
#import "ZMCAFManegeritem.h"
#import "ZMCLoginViewController.h"
#import "ZMCNavigationController.h"
#import "ZMCURL.h"


@interface ZMCTokenTool()

@property (nonatomic, copy) NSString *refreshtoken;

@end

static ZMCTokenTool *shared = nil;
@implementation ZMCTokenTool

+ (ZMCTokenTool *)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[ZMCTokenTool alloc] init];
        shared.tokenItem = [[ZMCTokenResultItem alloc] init];
        shared.tokenItem.access_token = TOKEN;
        shared.tokenItem.expire_time = EXPIRE_TIME;
        shared.tokenItem.refresh_token = REFRESH_TOKEN;
    });
    return shared;
}

- (void)getAccess_tokenWithRefresh_token:(getToken)tokenBlock{
    
//    if (self.tokenItem.refresh_token) {
//        _refreshtoken = self.tokenItem.refresh_token;
//    }else{
        _refreshtoken = REFRESH_TOKEN;
//        ZMCLog(@"refreshtoken----1>>>%@", _refreshtoken);
//    }
    if (_refreshtoken.length == 0) {
        if ([UserInfo isLogin]) {
            [UserInfo loginOut];
        }
        return;
    }
    
    NSString *acctoken = TOKEN;
    if (!acctoken) {
        tokenBlock(nil);
        return;
    }else{
        
        NSString *expireTime = EXPIRE_TIME;
        NSString *loginTime = LOGIN_TIME;
        
        NSString *timeSP = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        if ([expireTime integerValue] - 200 + [loginTime integerValue] > [timeSP integerValue]) {
            if (tokenBlock) {
                tokenBlock(TOKEN);
            }
        }else{
                NSString *urlstr = [NSString stringWithFormat:uURefresh_token, _refreshtoken];
                
                [HYBNetworking getWithUrl:urlstr refreshCache:YES success:^(id response) {
                    ZMCLog(@"置换成功");
                    ZMCTokenResultItem *item = [ZMCTokenResultItem mj_objectWithKeyValues:response[@"result"]];
                    
                    if (![response[@"err_msg"] isEqualToString:@"OK"]) {

                        NSString *str = [USER_DEFAULT objectForKey:@"refresh_token"];
                        ZMCLog(@"错误代码--->>>>%@---%@-----%@", response[@"err_msg"], response[@"err_code"], str);
//
                        [USER_DEFAULT removeObjectForKey:@"access_token"];
                        [USER_DEFAULT removeObjectForKey:@"refresh_token"];
                        [USER_DEFAULT removeObjectForKey:@"expire_time"];
                        [USER_DEFAULT removeObjectForKey:@"login_time"];
                        
                        return;
                    }else{
                        
                        // 保存toke值
                        [USER_DEFAULT setObject:response[@"result"][@"access_token"] forKey:@"access_token"];
                        [USER_DEFAULT setObject:response[@"result"][@"refresh_token"] forKey:@"refresh_token"];
                        [USER_DEFAULT setObject:response[@"result"][@"expire_time"] forKey:@"expire_time"];
                        NSString *timeSp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
                        [USER_DEFAULT setObject:timeSp forKey:@"login_time"];
                        
                        [USER_DEFAULT synchronize];
                        
                        _tokenItem = item;
                        if (tokenBlock) {
                            tokenBlock(response[@"result"][@"access_token"]);
                        }
                    }
                } fail:^(NSError *error) {
                    ZMCLog(@"置换失败");
                }];
        }
    }
    
}

@end
