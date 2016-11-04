//
//  DistributionTimeVC.h
//  YiHaiFarm
//
//  Created by Naive on 15/12/7.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributionTimeVC : UIViewController

@property (nonatomic,strong) void(^getTime)(NSString *date,NSString *time);
//@property(nonatomic,assign) int is_preSale;
//@property (nonatomic, assign) NSInteger pre_sale_id;

@end
