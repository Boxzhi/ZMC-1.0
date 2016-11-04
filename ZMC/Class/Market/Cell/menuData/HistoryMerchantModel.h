//
//  HistoryMerchantModel.h
//  ZMC
//
//  Created by Naive on 16/5/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HistoryMerchantResult,HistoryMerchantData;
@interface HistoryMerchantModel : NSObject

@property (nonatomic, strong) HistoryMerchantResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface HistoryMerchantResult : NSObject

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray<HistoryMerchantData *> *data;

@property (nonatomic, assign) NSInteger total_pages;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page_size;

@end

@interface HistoryMerchantData : NSObject

@property (nonatomic, assign) NSInteger data_id;

@property (nonatomic, copy) NSString *name;

@end