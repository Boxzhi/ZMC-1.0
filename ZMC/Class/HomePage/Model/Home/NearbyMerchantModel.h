//
//  NearbyMerchantModel.h
//  ZMC
//
//  Created by Naive on 16/7/11.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyMerchantModel : NSObject

@property (nonatomic, strong) NSString *booth_no;

@property (nonatomic, strong) NSArray *goods;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger selling_goods_cnt;

@property (nonatomic, assign) NSInteger sold_orders_cnt;

@property (nonatomic, strong) NSString *pic;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) NSString *market_name;

@end
