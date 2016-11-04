//
//  ZMCMyintegralManger.h
//  ZMC
//
//  Created by Will on 16/5/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCMyintegralManger : NSObject

//会员签到
+ (void)is_signin:(NSString *)signin andResult:(void(^)(NSDictionary *result))result;

/**
 *  获取积分规则
 */
+ (void)getMemberPoints:(void(^)(NSDictionary *))result;



@end
