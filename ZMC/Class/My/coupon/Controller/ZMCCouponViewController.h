//
//  ZMCCouponViewController.h
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DiscountModel.h"

@interface ZMCCouponViewController : UITableViewController

@property(nonatomic,copy)   void(^ didSelect)(DiscountData *data);
@property(nonatomic, strong) NSString *delivery_way_id;
@property(nonatomic, strong) NSString *list;

@property(nonatomic, assign) int isPerson;

@end
