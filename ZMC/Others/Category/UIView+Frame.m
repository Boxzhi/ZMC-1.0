//
//  UIView+Frame.m
//  01-BuDeJie
//
//  Created by xmg on 16/1/18.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (BOOL)zmc_intersectWithView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);
}

- (CGFloat)zmc_height
{
    return self.frame.size.height;
}
- (void)setZmc_height:(CGFloat)zmc_height
{
    CGRect frame = self.frame;
    frame.size.height = zmc_height;
    self.frame = frame;
}
- (CGFloat)zmc_width
{
     return self.frame.size.width;
}

- (void)setZmc_width:(CGFloat)zmc_width
{
    CGRect frame = self.frame;
    frame.size.width = zmc_width;
    self.frame = frame;
}

- (void)setZmc_x:(CGFloat)zmc_x
{
    CGRect frame = self.frame;
    frame.origin.x = zmc_x;
    self.frame = frame;

}
- (CGFloat)zmc_x
{
    return self.frame.origin.x;
}

- (void)setZmc_y:(CGFloat)zmc_y
{
    CGRect frame = self.frame;
    frame.origin.y = zmc_y;
    self.frame = frame;
}
- (CGFloat)zmc_y
{
    return self.frame.origin.y;
}

- (void)setZmc_centerX:(CGFloat)zmc_centerX
{
    CGPoint center = self.center;
    center.x = zmc_centerX;
    self.center = center;
}
- (CGFloat)zmc_centerX
{
    return self.center.x;
}
- (void)setZmc_centerY:(CGFloat)zmc_centerY
{
    CGPoint center = self.center;
    center.y = zmc_centerY;
    self.center = center;
}
- (CGFloat)zmc_centerY
{
    return self.center.y;
}
@end
