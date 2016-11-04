//
//  OrderMoneyModel.h
//  YiHaiFarm
//
//  Created by Naive on 16/1/11.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderMoneyResult;
@interface OrderMoneyModel : NSObject

@property (nonatomic, strong) OrderMoneyResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface OrderMoneyResult : NSObject

@property (nonatomic, assign) float freight;

@property (nonatomic, assign) float total_money;

@property (nonatomic, assign) float discount_money;

@property (nonatomic, assign) float balance;

@property (nonatomic, assign) float goods_money;

@property (nonatomic, assign) float ordinary_money;

@property (nonatomic, assign) int points_deduction_money;

@property (nonatomic, assign) int use_points;

@property (nonatomic, assign) int available_points;

@property (nonatomic, assign) float ratio;

@property (nonatomic, assign) int no_freight_limit;


@end

