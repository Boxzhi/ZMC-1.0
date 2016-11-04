//
//  GoodsDetailHeadCell.h
//  ZMC
//
//  Created by Naive on 16/5/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDateilModel.h"
#import <SDCycleScrollView.h>

@interface GoodsDetailHeadCell : UITableViewCell <UIScrollViewDelegate,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_lab;
@property (weak, nonatomic) IBOutlet UILabel *merchantName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescription_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;

@property (weak, nonatomic) IBOutlet UIButton *goodsDecrease_btn;
@property (weak, nonatomic) IBOutlet UIButton *goodsIncrease_btn;

- (void)setGoodsDetailHead:(GoodsDetailResult *)model;

@end
