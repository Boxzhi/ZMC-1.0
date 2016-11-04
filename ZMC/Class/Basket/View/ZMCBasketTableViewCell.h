//
//  BasketTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/4/21.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppongCartsModel.h"

@interface ZMCBasketTableViewCell : UITableViewCell

//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *activie_lab;

//商品标题
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;

//商品价格绿色字体部分,后面的单位需要再连过来
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

//商品数量输入框
@property (weak, nonatomic) IBOutlet UITextField *goodsCountTF;

//减号和加号按钮
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

- (void)setBaseketCooksInfo:(ShoppongCartsCooks *)model;

- (void)setBaseketGoodsInfo:(ShoppongCartsGooods *)model;


@end
