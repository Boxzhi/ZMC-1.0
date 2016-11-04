//
//  ZMCPaymetsItem.h
//  ZMC
//
//  Created by MindminiMac on 16/6/4.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCPaymetsItem : NSObject

@property (nonatomic, strong) NSString *refund_time;

@property (nonatomic, strong) NSString *status_name;

@property (nonatomic, strong) NSNumber *refund_money;

@property (nonatomic, strong) NSNumber *status;

@end
