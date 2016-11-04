//
//  ZMCRefreshHeader.m
//  01-BuDeJie
//
//  Created by ZMC on 16/1/31.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "ZMCRefreshHeader.h"

@interface ZMCRefreshHeader()
@property (nonatomic, weak) UIImageView *logoView;
@end

@implementation ZMCRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    // 自动切换透明度
    self.automaticallyChangeAlpha = YES;
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 修改状态文字的颜色
//    self.stateLabel.textColor = ThemeGreenColor;
    // 修改状态文字
//    [self setTitle:@"赶紧再下拉" forState:MJRefreshStateIdle];
//    [self setTitle:@"松开🐴上刷新" forState:MJRefreshStatePulling];
//    [self setTitle:@"正在玩命刷新中..." forState:MJRefreshStateRefreshing];
    
    // 添加logo
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgre"]];
    [self addSubview:logoView];
    self.logoView = logoView;
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
//    self.stateLabel.zmc_centerX = self.zmc_width * 0.5 - 50;
//    self.lastUpdatedTimeLabel.zmc_centerX = self.zmc_width * 0.5 - 30;
//    self.arrowView.zmc_centerX -= 50;

    self.logoView.zmc_centerX = self.zmc_width * 0.5;
    self.logoView.zmc_y = - self.logoView.zmc_height;
}

@end
