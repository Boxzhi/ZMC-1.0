//
//  ActivityListModel.h
//  ZMC
//
//  Created by Naive on 16/6/8.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActivityListResult,ActivityListData;
@interface ActivityListModel : NSObject

@property (nonatomic, strong) ActivityListResult *result;

@property (nonatomic, copy) NSString *err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface ActivityListResult : NSObject

@property (nonatomic, assign) NSInteger page_size;

@property (nonatomic, assign) NSInteger total_pages;

@property (nonatomic, strong) NSArray<ActivityListData *> *data;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page;

@end

@interface ActivityListData : NSObject

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type_name;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger data_id;

@end