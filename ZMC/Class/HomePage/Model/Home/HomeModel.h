//
//  HomeModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/16.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic, strong) NSArray *goodsSpecialsList;
@property (nonatomic, strong) NSArray *goodsHotList;
@property (nonatomic, strong) NSArray *carousels;
@property (nonatomic, strong) NSArray *nearbyMerchantList;

@end
