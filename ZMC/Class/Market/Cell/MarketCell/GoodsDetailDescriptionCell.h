//
//  GoodsDetailDescriptionCell.h
//  ZMC
//
//  Created by Naive on 16/5/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDateilModel.h"

@interface GoodsDetailDescriptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftTitle_lab;
@property (weak, nonatomic) IBOutlet UIView *leftBgView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UILabel *rightTitle_lab;
@property (weak, nonatomic) IBOutlet UIView *rightBgView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;


- (void)setGoodsDetailDescription:(GoodsDetailResult *)model;

@end
