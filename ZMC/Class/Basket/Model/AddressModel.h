//
//  AddressModel.h
//  ZMC
//
//  Created by Naive on 16/5/25.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressResult;
@interface AddressModel : NSObject

@property (nonatomic, strong) AddressResult *result;

@property (nonatomic, copy) NSString *err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface AddressResult : NSObject

@property (nonatomic, assign) NSInteger address_id;

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *province_name;

@property (nonatomic, assign) NSInteger district_id;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, assign) BOOL is_default;

@property (nonatomic, copy) NSString *street_address;

@property (nonatomic, assign) NSInteger province_id;

@property (nonatomic, copy) NSString *district_name;

@end