//
//  MerchantGoodsCell.h
//  ZMC
//
//  Created by Naive on 16/6/6.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantGoodsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_lab;
@property (weak, nonatomic) IBOutlet UIButton *goodsBtn;


@end
