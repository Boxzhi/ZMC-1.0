//
//  DeliverTypeModel.h
//  YiHaiFarm
//
//  Created by Naive on 16/1/6.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DeliverTypeResult,DeliverTypeList;
@interface DeliverTypeModel : NSObject

@property (nonatomic, strong) DeliverTypeResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface DeliverTypeResult : NSObject

@property (nonatomic, strong) NSArray<DeliverTypeList *> *data;

@end

@interface DeliverTypeList : NSObject

@property (nonatomic, assign) NSInteger data_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *dec;

@end

