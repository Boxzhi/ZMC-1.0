//
//  ZMCMyGroupItem.h
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCMyGroupItem : NSObject
/** 头部标题*/
@property (nonatomic ,copy)NSString *hederTitle;
/** 尾部标题*/
@property (nonatomic ,copy)NSString *footTitle;

/** 行模型数组*/
@property (nonatomic ,strong) NSArray *items;

+ (instancetype)groupItem:(NSArray *)items;
@end
