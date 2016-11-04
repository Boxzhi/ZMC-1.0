//
//  UserInfo.h
//  YHPromotion
//
//  Created by Naive on 16/3/30.
//  Copyright © 2016年 Naive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoResult;
@interface UserInfo : NSObject


@property (nonatomic, strong) UserInfoResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

+ (BOOL)isLogin;

+ (void)loginOut;

/**
 单例
 @returns
 */
+(UserInfo *) share;

/**
 *  退出登录时，清除用户信息
 */
- (void)loginOutForUserInfoModel;


@end
@interface UserInfoResult : NSObject

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *qrcode;

@property (nonatomic, assign) float balance;

@property (nonatomic, assign) float order_balance;

@property (nonatomic, assign) NSInteger order_total;

@property (nonatomic, assign) float register_balance;

@property (nonatomic, assign) NSInteger register_total;

@property (nonatomic, assign) NSInteger user_id;


@end
