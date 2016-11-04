//
//  ZMCAFManegeritem.h
//  ZMC
//
//  Created by Will on 16/5/16.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getResult)(NSString *result);

@interface ZMCAFManegeritem : NSObject

@property (nonatomic, copy) getResult getResultBlock;

// 验证码
+ (void)setRegistercaptchaNumber:(NSString *)number type:(NSNumber *)type andResult:(void(^)(NSDictionary *result))result;

// 注册1
+ (void)setRegisterNumber:(NSString *)number Msg:(NSString *)msg andResult:(void(^)(NSDictionary *result))result;

// 注册2
+ (void)setRegisterOnepassword:(NSString *)onepwd Twopassword:(NSString *)twopwd andPzresult:(NSString *)pzresult;

// 登录
+ (void)setLoginTelephonenumber:(NSString *)number password:(NSString *)pwd andToken:(void(^)(NSDictionary *tokenDic))tokenDic;


// 获取会员信息
+ (void)setVipinfo:(void(^)(NSDictionary *vipResult))vipResult;



// 置换TOKEN
+ (void)getTokenWithRefresh_token:(NSString *)refresh_token andResult:(void(^)(NSDictionary *result))result;


// 忘记密码1
+ (void)postFgpwdNumber:(NSString *)number Msg:(NSString *)msg andResult:(void(^)(NSDictionary *result))result;

// 忘记密码2
+ (void)postFgpwdOnepassword:(NSString *)onepwd Twopassword:(NSString *)twopwd token:(NSString *)token andResult:(void(^)(NSDictionary *result))result;

@end

