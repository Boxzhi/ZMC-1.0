//
//  OrderDetailVC.h
//  ZMC
//
//  Created by Naive on 16/6/1.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "RefreshTableViewController.h"


typedef NS_ENUM(NSUInteger, TapStatus) {
    /**
     *  订单详情
     */
    OrderDetailStatus = 0,
    /**
     *  物流详情
     */
    OrderTrailStatus =1,
    
};

@interface OrderDetailVC : RefreshTableViewController

@property (nonatomic,strong) NSString *order_id;

@end
