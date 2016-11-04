//
//  ZMCPaymentsManger.h
//  ZMC
//
//  Created by Will on 16/5/23.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCPaymentsManger : NSObject

// 查询用户退款记录
+ (void)getPayMentRelust:(void(^)(NSDictionary *result))result;
// 申请退款
+ (void)postPayMentMonsy:(NSNumber *)money relust:(void(^)(NSDictionary *result))result;

@end
