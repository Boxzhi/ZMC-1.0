//
//  SeasoningsTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCSeasoningsTableViewCell : UITableViewCell

/**
 *  第一种调料的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *kindOne;

/**
 *  第一种调料的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *countOne;


@end
