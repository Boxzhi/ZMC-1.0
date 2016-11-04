//
//  UIView+Frame.h
//  01-BuDeJie
//
//  Created by xmg on 16/1/18.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat zmc_x;
@property CGFloat zmc_y;
@property CGFloat zmc_width;
@property CGFloat zmc_height;
@property CGFloat zmc_centerX;
@property CGFloat zmc_centerY;

/**
 *  判断self和view是否重叠
 */
- (BOOL)zmc_intersectWithView:(UIView *)view;

@end
