//
//  ZMCAFManegeritem.m
//  ZMC
//
//  Created by Will on 16/5/16.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCAFManegeritem.h"
#import "AFManegerHelp.h"
#import "ZMCURL.h"
#import "ZMCTokenTool.h"

@interface ZMCAFManegeritem()


@end

@implementation ZMCAFManegeritem


// 验证码
+ (void)setRegistercaptchaNumber:(NSString *)number type:(NSNumber *)type andResult:(void(^)(NSDictionary *result)) result{
    
    NSDictionary *parameters =@{
                                @"account" : number,
                                @"type" : type
                                };
    [HYBNetworking postWithUrl:uUCaptcha refreshCache:NO params:parameters success:^(id response) {
        result(response);
        ZMCLog(@"验证码---> %@", response[@"result"]);
    } fail:^(NSError *error) {
        ZMCLog(@" ---> %@ <----", error);
    }];
    
//    [AFManegerHelp POST:uUCaptcha parameters:parameters success:^(id responseObjeck) {
//        ZMCLog(@"成功 --->  %@   <---", responseObjeck);
//        ZMCLog(@"验证码---> %@", responseObjeck[@"result"]);
//        result(responseObjeck);
//    } failure:^(NSError *error) {
//        ZMCLog(@"失败");
//        ZMCLog(@" ---> %@ <----", error);
//    }];
    
}


// 注册1
+ (void)setRegisterNumber:(NSString *)number Msg:(NSString *)msg andResult:(void(^)(NSDictionary *result))result{
    
    NSDictionary *parameters = @{
                                 @"account" : number,
                                 @"verification" : msg
                                 };
    
    [HYBNetworking postWithUrl:uURegister refreshCache:NO params:parameters success:^(id response) {
        ZMCLog(@"成功 --> %@", response);
        result(response);
    } fail:^(NSError *error) {
        ZMCLog(@"失败 --> %@", error);
    }];
    
//    [AFManegerHelp POST:uURegister parameters:parameters success:^(id responseObjeck) {
//        ZMCLog(@"成功 --> %@", responseObjeck);
//        result(responseObjeck);
//    } failure:^(NSError *error) {
//        ZMCLog(@"失败 --> %@", error);
//    }];
}


// 注册2
+ (void)setRegisterOnepassword:(NSString *)onepwd Twopassword:(NSString *)twopwd andPzresult:(NSString *)pzresult{
    
    NSDictionary *parameters = @{
                                 @"password" : onepwd,
                                 @"repeat_passwd" : twopwd,
                                 @"token" : pzresult,
                                 };
    
    [HYBNetworking postWithUrl:uURegisterPassword refreshCache:NO params:parameters success:^(id response) {
        ZMCLog(@"成功注册--->%@", response);
    } fail:^(NSError *error) {
        ZMCLog(@"注册失败--->%@", error);
    }];
    
//    [AFManegerHelp POST:uURegisterPassword parameters:parameters success:^(id responseObjeck) {
//        ZMCLog(@"成功注册--->%@", responseObjeck);
//        
//    } failure:^(NSError *error) {
//        ZMCLog(@"注册失败--->%@", error);
//    }];
}


// 登录
+ (void)setLoginTelephonenumber:(NSString *)number password:(NSString *)pwd andToken:(void(^)(NSDictionary *tokenDic))tokenDic{
    
    NSDictionary *params = @{
                             @"account" : number,
                             @"password" : pwd
                             };
    
    [HYBNetworking postWithUrl:uULogin refreshCache:YES params:params success:^(NSDictionary *response) {
        ZMCLog(@"需要的token--> %@", response[@"result"]);
        
        ZMCLog(@"%@", [USER_DEFAULT objectForKey:@"access_token"]);
        tokenDic(response);
        
    } fail:^(NSError *error) {
        ZMCLog(@"%@", error);
    }];
    
}



// 获取会员信息
+ (void)setVipinfo:(void(^)(NSDictionary *vipResult)) vipResult{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token){
//        ZMCLog(@"token---1>>>>>>%@", token);
//        NSString *token = [USER_DEFAULT objectForKey:@"access_token"];
        NSString *url = [NSString stringWithFormat:uUUserMassege, token];
        [HYBNetworking getWithUrl:url refreshCache:YES success:^(NSDictionary *response) {
            ZMCLog(@"获取会员信息%@", response);
            if (![response[@"err_msg"] isEqualToString:@"OK"]) {
                ZMCLog(@"没获取到会员信息");
                [USER_DEFAULT removeObjectForKey:@"access_token"];
                [USER_DEFAULT removeObjectForKey:@"refresh_token"];
                [USER_DEFAULT removeObjectForKey:@"expire_time"];
                [USER_DEFAULT removeObjectForKey:@"login_time"];
                [USER_DEFAULT setObject:@"0" forKey:ISLOGIN];
                ZMCLog(@"%@-------%@------%@",token, TOKEN, REFRESH_TOKEN);
                NSDictionary *vipInfo = @{
                                          @"balance" : @"0",
                                          @"points" : @"0"
                                          };
                vipResult(vipInfo);
            }else{
                
                vipResult(response[@"result"]);
            }
            
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
        }];
    }];

}


// 置换TOKEN
+ (void)getTokenWithRefresh_token:(NSString *)refresh_token andResult:(void(^)(NSDictionary *result))result{
    
    ZMCLog(@"用来置换的token--->>%@", refresh_token);
    NSString *urlstr = [NSString stringWithFormat:uURefresh_token, refresh_token];
    
    [HYBNetworking getWithUrl:urlstr refreshCache:YES success:^(id response) {
        result(response);
        ZMCLog(@"置换结果----->>>%@", response[@"err_msg"]);
        ZMCLog(@"置换成功");
    } fail:^(NSError *error) {
        ZMCLog(@"置换失败");
    }];
    
}


// 忘记密码1
+ (void)postFgpwdNumber:(NSString *)number Msg:(NSString *)msg andResult:(void(^)(NSDictionary *result))result{
    
    NSString *urlStr = @"http://115.159.227.219:8088/fanfou-api/member/reset/password/step1";
    
    NSDictionary *params = @{
                             @"account" : number,
                             @"verification" : msg
                             };
    
    [HYBNetworking postWithUrl:urlStr refreshCache:YES params:params success:^(id response) {
        result(response);
    } fail:^(NSError *error) {
        ZMCLog(@"%@", error);
    }];
}

// 忘记密码2
+ (void)postFgpwdOnepassword:(NSString *)onepwd Twopassword:(NSString *)twopwd token:(NSString *)token andResult:(void(^)(NSDictionary *result))result{
    
}



@end
