//
//  ZMCMyHeaderItem.h
//  ZMC
//
//  Created by Will on 16/5/18.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCMyHeaderItem : NSObject


// 头像
@property (nonatomic, strong) NSString *avatar_url;
// 昵称
@property (nonatomic, strong) NSString *nick_name;
// 会员等级
@property (nonatomic, strong) NSString *member_level;
// 个性签名
@property (nonatomic, strong) NSString *signature;
// 余额
@property (nonatomic, strong) NSString *balance;
// 冻结金额
@property (nonatomic, strong) NSString *frozen_funds;
// 会员总积分
@property (nonatomic, strong) NSString *points;
//
//
// 性别
@property (nonatomic, strong) NSNumber *gender;
// 会员类型
@property (nonatomic, strong) NSNumber *member_type;
// 手机号
@property (nonatomic, strong) NSString *mobile;
// 真实姓名
@property (nonatomic, strong) NSString *real_name;
// 注册时间
@property (nonatomic, strong) NSNumber *register_time;
//
@property (nonatomic, strong) NSString *member_market;

@end
