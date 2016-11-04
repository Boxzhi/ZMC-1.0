//
//  ZMCCouponManger.h
//  ZMC
//
//  Created by Will on 16/5/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCCouponManger : NSObject

+ (void)queCouponResult:(void(^)(NSDictionary *result))result;

@end
