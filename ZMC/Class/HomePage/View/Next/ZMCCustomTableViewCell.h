//
//  CustomTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/4/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCCustomTableViewCell : UITableViewCell

//商品的图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

//商品的名字
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;

//商品的市场参考价格,带有单位,需要拼接字符串
@property (weak, nonatomic) IBOutlet UILabel *referencePrice;

//商品的真是价格,没有单位
@property (weak, nonatomic) IBOutlet UILabel *realPrice;

//商品的真是价格对应的单位
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@end
