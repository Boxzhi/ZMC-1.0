//
//  UITableViewCell+Category.h
//  YueDongApp
//
//  Created byDaniel on 14-8-5.
//  Copyright (c) 2014年Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Category)

/**
 *  设置cell重用的identifier
 *
 *  @return cell重用的identifier
 */
+ (NSString *)cellIdentifier;

@end
