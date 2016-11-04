//
//  GoodsSearchResultModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/11.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsSearchResultModel : NSObject


@property (nonatomic, strong) NSNumber *goods_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *unit;
@property (nonatomic, strong) NSString *unit_name;
@property (nonatomic, strong) NSString *merchant_name;
@property (nonatomic, strong) NSNumber *saled_count;



@end
