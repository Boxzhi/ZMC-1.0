//
//  SpecialTodayModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/10.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialTodayModel : NSObject


@property (nonatomic, strong) NSNumber *goods_id;
@property (nonatomic, strong) NSString *list_pic;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *short_intro;
@property (nonatomic, strong) NSNumber *special_price;
@property (nonatomic, strong) NSNumber *unit;
@property (nonatomic, strong) NSString *unit_name;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSString *market_unit;
@property (nonatomic, strong) NSString *market_unit_name;
@property (nonatomic, strong) NSNumber *original_price;
@property (nonatomic, strong) NSNumber *sku_price;


@end
