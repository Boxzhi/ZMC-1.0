//
//  ZMCPayManger.h
//  ZMC
//
//  Created by Will on 16/5/24.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCPayManger : NSObject

+ (void)getPayPrepaid:(void(^)(NSArray *result))result;

/**
 *  获取充值数据
 */
+ (void)getPayRecharge:(NSNumber *)money andResult:(void(^)(NSDictionary *))result;

@end
