//
//  MallTool.m
//  YiHaiFarm
//
//  Created by Daniel on 16/1/15.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "MallTool.h"

@implementation MallTool

/**
 *  加入购物车动画
 *
 *  @param image        要做动画的图片
 *  @param endAnimation 结束动作回调
 */
+(void)addSHopAnimation:(UIImageView *)shopImgeView withPoint:(CGPoint)currentPoint perform:(void(^)(CALayer *imgLayer))endAnimation{
    //加入购物车动画效果
    CALayer *transitionLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer.opacity = 1.0;
    transitionLayer.contents = (id)shopImgeView.layer.contents;
    transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:shopImgeView.bounds fromView:shopImgeView];
    int twidth= transitionLayer.frame.size.width;
    int thight= transitionLayer.frame.size.height;
    transitionLayer.frame=CGRectMake(transitionLayer.frame.origin.x+twidth/2, transitionLayer.frame.origin.y+thight/2, 1, 1);
    //    transitionLayer.position =shopImgeView.center;
    NSLog(@"%f,%f",currentPoint.x,currentPoint.y);
    if (currentPoint.x<SCREEN_SIZE.width/2.0f) {
        
        transitionLayer.position =CGPointMake(SCREEN_SIZE.width/2.0f-50*HANGCOEFFICIENT, currentPoint.y+50*GAOCOEFFICIENT);
    }else{
        
        transitionLayer.position =CGPointMake(SCREEN_SIZE.width-50*HANGCOEFFICIENT, currentPoint.y+50*GAOCOEFFICIENT);
    }
    
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
    [CATransaction commit];
    
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    
    //目标点
    CGPoint toPoint = CGPointMake(SCREEN_W/4.0f * 3 - 20, SCREEN_SIZE.height-48);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(SCREEN_W/4.0f * 3 - 60,currentPoint.y+30)];
    //关键帧1
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.removedOnCompletion = NO;
    
    //关键帧2
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    pulse.duration =0.8;
    pulse.autoreverses = NO;
    thight =15;
    pulse.fromValue = [NSNumber numberWithFloat:thight*1.2];
    pulse.toValue = [NSNumber numberWithFloat:thight*1];
    [transitionLayer addAnimation:pulse forKey:@"scale"];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.8;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    [transitionLayer addAnimation:group forKey:@"opacity"];
    
    if (endAnimation) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            endAnimation(transitionLayer);
        });
    }
}


@end
