//
//  ZMCpickerViewItem.h
//  ZMC
//
//  Created by Will on 16/5/24.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCPickerViewItem : NSObject

// 收货人
@property (nonatomic, strong) NSString *consignee;
// 电话
@property (nonatomic, strong) NSString *mobile;
// 省名称
@property (nonatomic, strong) NSString *province_name;
// 省编号id
@property (nonatomic, strong) NSNumber *province_id;
// 市名称
@property (nonatomic, strong) NSString *city_name;
// 市编号id
@property (nonatomic, strong) NSNumber *city_id;
// 区名称
@property (nonatomic, strong) NSString *district_name;
// 区编号id
@property (nonatomic, strong) NSNumber *district_id;
// 详细地址
@property (nonatomic, strong) NSString *street_address;
// 是否为默认地址
@property (nonatomic, assign) BOOL is_default;

// 收货地址编号
@property (nonatomic, strong) NSNumber *id_;

@end
