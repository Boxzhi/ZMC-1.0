//
//  CookBookDetailFoodMaterialModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookBookDetailFoodMaterialModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *unit;
@property (nonatomic, strong) NSNumber *goods_id;
@property (nonatomic, strong) NSString *unit_name;
@property (nonatomic, strong) NSString *short_intro;
@property (nonatomic, strong) NSString *weight;

@end
