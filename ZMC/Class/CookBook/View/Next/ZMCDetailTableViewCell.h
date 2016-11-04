//
//  ZMCDetailTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/6/15.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortLabel;

@end
