//
//  ZMCCookBookTVCell.h
//  ZMC
//
//  Created by 睿途网络 on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CookBookModel;
@interface ZMCCookBookTVCell : UITableViewCell

/**
 *  菜谱的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPic;

/**
 *  菜谱的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *dishName;

/**
 *  选择的人数
 */
@property (weak, nonatomic) IBOutlet UILabel *selectNum;

/**
 *  收藏的人数
 */
@property (weak, nonatomic) IBOutlet UILabel *favouriteNum;

- (void)getModelDataToControl:(CookBookModel *)model;

@end
