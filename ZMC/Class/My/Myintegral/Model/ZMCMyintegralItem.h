//
//  ZMCMyintegralItem.h
//  ZMC
//
//  Created by Will on 16/5/18.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCMyintegralItem : NSObject

// 已签到总次数
@property (nonatomic, strong) NSString *signin_times;
// 本次签到积分
@property (nonatomic, strong) NSString *points;
// 明天签到得分
@property (nonatomic, strong) NSString *tomorrow_points;
// 总积分
@property (nonatomic, strong) NSString *total_points;
// 是否签到
@property (nonatomic, strong) NSString *has_signed;

@end
