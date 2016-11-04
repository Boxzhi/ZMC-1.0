//
//  ZMCStoreCell.h
//  ZMC
//
//  Created by MindminiMac on 16/7/12.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCStoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerimage;

@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UILabel *shopNumber;

@property (weak, nonatomic) IBOutlet UILabel *sellLabel;

@property (weak, nonatomic) IBOutlet UILabel *soldLabel;
@end
