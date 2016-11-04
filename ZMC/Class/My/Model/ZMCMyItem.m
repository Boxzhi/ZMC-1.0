//
//  ZMCMyItem.m
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyItem.h"

@implementation ZMCMyItem
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title{
    ZMCMyItem *item = [[self alloc] init];
    
    item.image = image;
    item.title = title;
    
    return item;
}
@end
