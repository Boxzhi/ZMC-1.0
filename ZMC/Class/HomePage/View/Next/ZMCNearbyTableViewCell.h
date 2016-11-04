//
//  NearbyTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/4/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCNearbyTableViewCell : UITableViewCell

/**
 *  菜场名字
 */
@property (weak, nonatomic) IBOutlet UILabel *marketNameLabel;


/**
 *  菜场信息
 */
@property (weak, nonatomic) IBOutlet UILabel *marketInfoLabel;
@end
