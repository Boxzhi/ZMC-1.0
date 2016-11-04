//
//  UIBarButtonItem+Item.h
//  01-BuDeJie
//
//  Created by will on 16/4/28.
//  Copyright © 2016年 will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

/**
 *  创建UIBarButtonItem,高亮
 *
 *  @param image    图片
 *  @param highImage 高亮图片
 *  @param target   监听者
 *  @param action   监听者调用的方法
 *
 */
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;
/**
 *  创建UIBarButtonItem,选中
 *
 *  @param image    图片
 *  @param highImage 高亮图片
 *  @param target   监听者
 *  @param action   监听者调用的方法
 *
 */
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action title:(NSString *)title;

/**
 *  创建返回按钮
 *
 *  @param image     返回按钮图片
 *  @param highImage 高亮图片
 *  @param target    监听者
 *  @param action    监听者调用的方法
 *  @param title     标题
 *
 */
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:( id)target action:(SEL)action title:(NSString *)title;


@end
