//
//  ZMCMyGroupItem.m
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyGroupItem.h"

@implementation ZMCMyGroupItem
+ (instancetype)groupItem:(NSArray *)items{
    ZMCMyGroupItem *group = [[self alloc] init];
    group.items = items;
    return group;
}
@end
