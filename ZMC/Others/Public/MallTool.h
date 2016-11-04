//
//  MallTool.h
//  YiHaiFarm
//
//  Created by Daniel on 16/1/15.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallTool : NSObject

/**
 *  加入购物车动画
 *
 *  @param image        要做动画的图片
 *  @param endAnimation 结束动作回调
 */
+(void)addSHopAnimation:(UIImageView *)shopImgeView withPoint:(CGPoint)currentPoint perform:(void(^)(CALayer *imgLayer))endAnimation;



@end
