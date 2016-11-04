//
//  UITabBar+badge.h
//  ZMC
//
//  Created by Naive on 16/6/17.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index; //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
