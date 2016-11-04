//
//  ZMCMyListItem.h
//  ZMC
//
//  Created by MindminiMac on 16/6/1.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCMyListItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *dinner_time;

@property (nonatomic, strong) NSNumber *total_count;

@property (nonatomic, strong) NSArray *bookcook_selected;

@property (nonatomic, strong) NSNumber *list_id;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *status_name;

@property (nonatomic, strong) NSString *start_time;

@property (nonatomic, strong) NSString *end_time;

@property (nonatomic, strong) NSArray *cookbook_members;

@end
