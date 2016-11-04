//
//  UILabel+StringFrame.h
//  YiHaiFarm
//
//  Created by Naive on 16/1/19.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  根据给定的Font以及str计算UILabel的frameSize
 */
@interface UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size;

@end
