//
//  ZMCMyItem.h
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZMCMyItem : NSObject
/** 图标 */
@property (nonatomic, strong) UIImage *image;

/** 标题*/
@property (nonatomic ,copy)NSString *title;

/** 子标题*/
@property (nonatomic ,copy)NSString *subTitle;

/** 点击这一行要做的操作*/
@property (nonatomic ,strong) void(^operationBlock)(NSIndexPath *indexPath);

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;

@end
