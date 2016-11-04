//
//  MerchantGoodsHeadCell.h
//  ZMC
//
//  Created by Naive on 16/7/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantGoodsHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopsImg;
@property (weak, nonatomic) IBOutlet UIImageView *shopsHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *shopsName_lab;
@property (weak, nonatomic) IBOutlet UILabel *shopsBooth_lab;
@property (weak, nonatomic) IBOutlet UILabel *shopsMarket_lab;
@property (weak, nonatomic) IBOutlet UIImageView *shopsStarImg;


@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UILabel *collectNum_lab;

@end
