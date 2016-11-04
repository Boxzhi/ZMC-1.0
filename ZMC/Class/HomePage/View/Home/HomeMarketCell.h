//
//  HomeMarketCell.h
//  ZMC
//
//  Created by Naive on 16/7/6.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMarketCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopsImg;
@property (weak, nonatomic) IBOutlet UILabel *shopsName_lab;
@property (weak, nonatomic) IBOutlet UILabel *shopsBooth_lab;
@property (weak, nonatomic) IBOutlet UILabel *shopsMarket_lab;
@property (weak, nonatomic) IBOutlet UIImageView *shopsStarImg;
@property (weak, nonatomic) IBOutlet UILabel *shopsNum_lab;
@property (weak, nonatomic) IBOutlet UILabel *shopsOrderNum_lab;
@property (weak, nonatomic) IBOutlet UILabel *shopsHeadName_lab;


@end
