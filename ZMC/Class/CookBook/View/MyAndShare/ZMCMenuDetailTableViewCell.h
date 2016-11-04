//
//  ZMCMenuDetailTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMCMyDetailItem;
@interface ZMCMenuDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) ZMCMyDetailItem *item;

/**
 *  第一道菜的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPictureOne;

/**
 *  第二道菜的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPictureTwo;

/**
 *  第三道菜的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPictureThree;

@end
